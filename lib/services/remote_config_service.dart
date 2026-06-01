import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AiPrompt {
  final String model;
  final String system;

  const AiPrompt({required this.model, required this.system});
}

class RemoteConfig {
  final Map<String, String> models;
  final String baseUrl;
  final String? workoutsUrl;
  final Map<String, String> prompts;
  final List<String> weatherExercises;

  const RemoteConfig({
    this.models = const {},
    this.baseUrl = 'https://openrouter.ai/api/v1/chat/completions',
    this.workoutsUrl,
    this.prompts = const {},
    this.weatherExercises = _defaultWeatherExercises,
  });

  static const _defaultWeatherExercises = [
    'worlds_greatest_stretch',
    'doorway_pec_openers',
    'cat_cow_transitions',
    'standing_side_bend',
  ];

  String get aiModel => models.values.isNotEmpty
      ? models.values.first
      : 'openrouter/free';

  String? prompt(String type) => prompts[type];

  AiPrompt? typedPrompt(String type) {
    final system = prompts[type];
    final model = models[type] ?? models.values.firstOrNull ?? 'openrouter/free';
    if (system == null) return null;
    return AiPrompt(model: model, system: system);
  }
}

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._();

  RemoteConfig _config = const RemoteConfig();
  RemoteConfig get config => _config;

  Future<void> load() async {
    await _loadLocalDefaults();

    final configUrl = dotenv.env['REMOTE_CONFIG_URL'] ?? '';
    if (configUrl.isEmpty) return;

    final remote = await _fetchRemote(configUrl);
    if (remote != null) {
      _config = remote;
    }
  }

  Future<void> _loadLocalDefaults() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/config/ai.json');
      _config = _parse(jsonDecode(jsonString));
    } catch (e) {
      print('[PFT] RemoteConfig: local load failed ($e) — using hardcoded defaults');
    }
  }

  Future<RemoteConfig?> _fetchRemote(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return _parse(jsonDecode(response.body));
      }
    } catch (e) {
      print('[PFT] RemoteConfig: remote fetch failed ($e) — keeping local');
    }
    return null;
  }

  RemoteConfig _parse(Map<String, dynamic> data) {
    // Models map (preferred)
    Map<String, String> models = {};
    final rawModels = data['models'];
    if (rawModels is Map) {
      for (final entry in rawModels.entries) {
        models[entry.key] = entry.value.toString();
      }
    }

    // Fallback: single default_model string applies to all prompt types
    if (models.isEmpty) {
      final fallback = data['default_model'] as String?;
      if (fallback != null) {
        final rawPrompts = data['prompts'] as Map<String, dynamic>?;
        if (rawPrompts != null) {
          for (final key in rawPrompts.keys) {
            models[key] = fallback;
          }
        }
      }
    }

    // Prompts
    final prompts = <String, String>{};
    final rawPrompts = data['prompts'] as Map<String, dynamic>?;
    if (rawPrompts != null) {
      for (final entry in rawPrompts.entries) {
        final value = entry.value;
        if (value is List) {
          prompts[entry.key] = value.join('\n');
        } else if (value is String) {
          prompts[entry.key] = value;
        }
      }
    }

    return RemoteConfig(
      models: models,
      baseUrl: (data['base_url'] as String?) ??
          'https://openrouter.ai/api/v1/chat/completions',
      workoutsUrl: data['workouts_url'] as String?,
      prompts: prompts,
      weatherExercises: (data['weather_exercises'] as List?)
              ?.cast<String>() ??
          RemoteConfig._defaultWeatherExercises,
    );
  }
}
