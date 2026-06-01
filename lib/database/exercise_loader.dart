import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'schemas/workout_configuration.dart';

class ExerciseLoader {
  static Future<void> loadFromAssets(Isar isar, {String? remoteUrl}) async {
    final existing = await isar.workoutConfigurations.where().anyId().findAll();
    if (existing.isNotEmpty) return;

    List<WorkoutConfiguration> allExercises = [];

    // Try remote URL first if provided
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      allExercises = await _fetchFromUrl(remoteUrl);
    }

    // Fall back to local assets
    if (allExercises.isEmpty) {
      allExercises = await _loadFromLocalAssets();
    }

    if (allExercises.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.workoutConfigurations.putAll(allExercises);
      });
    }
  }

  static Future<List<WorkoutConfiguration>> _fetchFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> items = jsonDecode(response.body) as List<dynamic>;
        return items.map((item) => _parseItem(item)).toList();
      }
    } catch (_) {}
    return [];
  }

  static Future<List<WorkoutConfiguration>> _loadFromLocalAssets() async {
    const categories = [
      'mobility',
      'walking',
      'endurance',
      'strength_machine',
      'bodyweight',
      'strength_weights',
      'cooldown',
    ];

    final allExercises = <WorkoutConfiguration>[];

    for (final cat in categories) {
      try {
        final jsonString =
            await rootBundle.loadString('assets/exercises/$cat.json');
        final List<dynamic> items = jsonDecode(jsonString) as List<dynamic>;
        for (final item in items) {
          allExercises.add(_parseItem(item));
        }
      } catch (_) {}
    }

    return allExercises;
  }

  static WorkoutConfiguration _parseItem(Map<String, dynamic> item) {
    return WorkoutConfiguration()
      ..exerciseId = item['exerciseId'] as String
      ..name = item['name'] as String
      ..category = item['category'] as String
      ..progressionTier = item['progressionTier'] as int
      ..instructions = (item['instructions'] as String?) ?? ''
      ..feelRight = (item['feelRight'] as String?) ?? ''
      ..feelWrong = (item['feelWrong'] as String?) ?? ''
      ..restTime = (item['restTime'] as String?) ?? ''
      ..sets = (item['sets'] as String?) ?? ''
      ..reps = (item['reps'] as String?) ?? ''
      ..duration = item['duration'] as String?
      ..distance = item['distance'] as String?
      ..notes = (item['notes'] as String?) ?? '';
  }
}
