import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../core/sanitize_response.dart';
import '../database/schemas/daily_session.dart';
import '../database/schemas/user_state.dart';
import 'remote_config_service.dart';

class OpenRouterService {
  static String get _baseUrl => RemoteConfigService().config.baseUrl;

  String? get _apiKey {
    final key = dotenv.env['OPENROUTER_API_KEY'];
    return key != null && key.isNotEmpty ? key : null;
  }

  static Future<bool> healthCheck() async {
    final key = dotenv.env['OPENROUTER_API_KEY'];
    if (key == null || key.isEmpty) {
      print('[PFT] AI: OPENROUTER_API_KEY not set — AI features disabled');
      return false;
    }

    final model = RemoteConfigService().config.aiModel;
    final baseUrl = RemoteConfigService().config.baseUrl;

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $key',
          'HTTP-Referer': 'https://pftpath.app',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {'role': 'user', 'content': 'Reply with only the word OK'}
          ],
          'max_tokens': 4,
        }),
      );

      if (response.statusCode == 200) {
        print('[PFT] AI: OpenRouter connected — model: $model');
        return true;
      } else {
        print('[PFT] AI: OpenRouter returned ${response.statusCode} — ${response.body}');
        return false;
      }
    } catch (e) {
      print('[PFT] AI: OpenRouter connection failed — $e');
      return false;
    }
  }

  String _inject(String template, Map<String, String> vars) {
    var result = template;
    for (final entry in vars.entries) {
      result = result.replaceAll('{{${entry.key}}}', entry.value);
    }
    return result;
  }

  String _logsText(List<DailySession> logs) {
    final entries = logs
        .where((s) => s.userNotes != null && s.userNotes!.isNotEmpty)
        .map((s) =>
            "'${s.date.toIso8601String().substring(0, 10)}: ${s.userNotes}'")
        .toList();
    return entries.isNotEmpty ? entries.join('\n') : 'No previous logs.';
  }

  Future<String?> generatePlan({required UserState? userState}) async {
    final apiKey = _apiKey;
    final prompt = RemoteConfigService().config.typedPrompt('plan');
    if (apiKey == null || userState == null || prompt == null) return null;

    final system = _inject(prompt.system, {
      'userName': userState.userName,
      'userAge': userState.userAge.toString(),
      'userWeight': userState.userWeight.toStringAsFixed(0),
      'userHeight': userState.userHeight.toStringAsFixed(1),
      'fitnessLevel': userState.fitnessLevel,
      'goals': userState.goals,
      'limitations': userState.limitations,
    });

    final payload = jsonEncode({
      'model': prompt.model,
      'messages': [
        {'role': 'system', 'content': system},
        {
          'role': 'user',
          'content': jsonEncode({
            'name': userState.userName,
            'age': userState.userAge,
            'weight_lbs': userState.userWeight,
            'height_in': userState.userHeight,
            'fitness_level': userState.fitnessLevel,
            'goals': userState.goals,
            'limitations': userState.limitations,
          }),
        },
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'HTTP-Referer': 'https://pftpath.app',
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]?['message']?['content'] as String?;
        if (content != null) return sanitizeAiResponse(content);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> generateBriefing({
    required String userName,
    required String stateLabel,
    required int streak,
    required bool isWeatherSkip,
    required String todayFocus,
    required List<DailySession> previousLogs,
    required List<String> targetExercises,
    String? fitnessLevel,
    String? goals,
    String? limitations,
  }) async {
    final apiKey = _apiKey;
    final prompt = RemoteConfigService().config.typedPrompt('briefing');
    if (apiKey == null || prompt == null) return null;

    final system = _inject(prompt.system, {
      'userName': userName,
      'stateLabel': stateLabel,
      'streak': streak.toString(),
      'isWeatherSkip': isWeatherSkip.toString(),
      'todayFocus': todayFocus,
      'fitnessLevel': fitnessLevel ?? 'Not set',
      'goals': goals ?? 'Not set',
      'limitations': limitations ?? 'Not set',
      'previousLogs': _logsText(previousLogs),
      'targetExercises': targetExercises.join(', '),
    });

    final context = {
      'User Name': userName,
      'State': stateLabel,
      'Streak': streak.toString(),
      'Weather Skip applied': isWeatherSkip.toString(),
      'Today Focus': todayFocus,
      'Fitness Level': fitnessLevel ?? 'Not set',
      'Goals': goals ?? 'Not set',
      'Limitations': limitations ?? 'Not set',
      'Previous Logs Notes': _logsText(previousLogs),
      'Target Exercises for Today': targetExercises,
    };

    final payload = jsonEncode({
      'model': prompt.model,
      'messages': [
        {'role': 'system', 'content': system},
        {'role': 'user', 'content': jsonEncode(context)},
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'HTTP-Referer': 'https://pftpath.app',
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]?['message']?['content'] as String?;
        if (content != null) return sanitizeAiResponse(content);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
