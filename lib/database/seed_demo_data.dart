import 'package:isar/isar.dart';
import 'schemas/daily_session.dart';
import 'schemas/user_state.dart';

Future<void> seedDemoData(Isar isar) async {
  final existing = await isar.dailySessions.where().anyId().findAll();
  if (existing.isNotEmpty) return;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final userState = UserState()
    ..currentProgressIndex = 4
    ..currentStreak = 3
    ..lastActiveDate = today
    ..historicalAILogs = [
      'Good morning, Applicant. Today we build on last week\'s foundation. Your walking form has improved — maintain that pelvic tilt. Focus on even breathing throughout.',
    ]
    ..userName = 'Applicant'
    ..userAge = 30
    ..userWeight = 180
    ..userHeight = 70
    ..fitnessLevel = 'beginner'
    ..goals = 'Build baseline fitness, pass PFT'
    ..limitations = 'None'
    ..aiGeneratedPlan = '';

  await isar.writeTxn(() async {
    await isar.userStates.put(userState);
  });

  final sessions = [
    _session(today.subtract(const Duration(days: 7)), true, false, ['walk_1mile', 'walk_1mile']),
    _session(today.subtract(const Duration(days: 6)), true, false, ['walk_1mile', 'mobility_cat_cow', 'cooldown_deep_breathing']),
    _session(today.subtract(const Duration(days: 5)), true, false, ['walk_1mile', 'walk_1mile', 'mobility_hip_circles']),
    _session(today.subtract(const Duration(days: 4)), false, true, ['worlds_greatest_stretch']),
    _session(today.subtract(const Duration(days: 2)), true, false, ['walk_1mile', 'mobility_leg_swings', 'walk_1mile', 'cooldown_standing_side_bend']),
    _session(today.subtract(const Duration(days: 1)), true, false, ['walk_1mile', 'mobility_arm_circles', 'walk_1mile', 'cooldown_quad_stretch']),
    _session(today, true, false, ['walk_1mile', 'mobility_torso_twist', 'walk_1mile']),
  ];

  for (final s in sessions) {
    await isar.writeTxn(() async {
      await isar.dailySessions.put(s);
    });
  }
}

DailySession _session(DateTime date, bool completed, bool weatherSkip, List<String> exerciseIds) {
  return DailySession()
    ..date = date
    ..isCompleted = completed
    ..isWeatherSkip = weatherSkip
    ..completedExerciseIds = exerciseIds
    ..userNotes = completed && !weatherSkip ? 'Felt good. Consistent pace.' : null
    ..performanceMetrics = '{}';
}
