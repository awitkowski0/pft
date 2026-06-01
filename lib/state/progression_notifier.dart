import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../core/progression_math.dart';
import '../database/isar_service.dart';
import '../database/schemas/daily_session.dart';
import '../database/schemas/user_state.dart';
import '../database/schemas/workout_configuration.dart';
import '../services/firestore_service.dart';
import '../services/remote_config_service.dart';

enum ProgressionLabel {
  normal,
  activeProgression,
  punishedRegression,
  weatherSkipActive,
  baseLoading,
}

class ProgressionState {
  final int currentProgressIndex;
  final int currentStreak;
  final DateTime lastActiveDate;
  final ProgressionLabel label;
  final DateTime? tierLockExpiry;
  final int completedSessionCount;
  final int maxStreak;
  final int currentTier;

  ProgressionState({
    this.currentProgressIndex = 0,
    this.currentStreak = 0,
    required this.lastActiveDate,
    this.label = ProgressionLabel.baseLoading,
    this.tierLockExpiry,
    this.completedSessionCount = 0,
    this.maxStreak = 0,
    this.currentTier = 1,
  });

  ProgressionState copyWith({
    int? currentProgressIndex,
    int? currentStreak,
    DateTime? lastActiveDate,
    ProgressionLabel? label,
    DateTime? tierLockExpiry,
    int? completedSessionCount,
    int? maxStreak,
    int? currentTier,
  }) {
    return ProgressionState(
      currentProgressIndex: currentProgressIndex ?? this.currentProgressIndex,
      currentStreak: currentStreak ?? this.currentStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      label: label ?? this.label,
      tierLockExpiry: tierLockExpiry ?? this.tierLockExpiry,
      completedSessionCount: completedSessionCount ?? this.completedSessionCount,
      maxStreak: maxStreak ?? this.maxStreak,
      currentTier: currentTier ?? this.currentTier,
    );
  }
}

class ProgressionNotifier extends Notifier<ProgressionState> {
  @override
  ProgressionState build() {
    _loadFromDb();
    return ProgressionState(lastActiveDate: DateTime.fromMillisecondsSinceEpoch(0));
  }

  Future<void> _loadFromDb() async {
    final isar = await IsarService().db;
    final userState = await isar.userStates.where().anyId().findFirst();
    final allSessions = await isar.dailySessions
        .where()
        .anyDate()
        .findAll();
    final completedSessions = allSessions
        .where((s) => s.isCompleted)
        .toList();

    final sessionCount = completedSessions.length;
    final maxStreak = calculateMaxStreak(allSessions);

    if (userState == null) {
      state = ProgressionState(
        lastActiveDate: DateTime.fromMillisecondsSinceEpoch(0),
        completedSessionCount: sessionCount,
        maxStreak: maxStreak,
        currentTier: 1,
        label: ProgressionLabel.baseLoading,
      );
      return;
    }

    final now = DateTime.now();
    final lastDate = userState.lastActiveDate;
    final delta = _daysBetween(lastDate, now);

    ProgressionLabel label = ProgressionLabel.normal;
    int progressIndex = userState.currentProgressIndex;
    int streak = userState.currentStreak;
    DateTime? tierLockExpiry;
    int currentTier = calculateTier(sessionCount);

    if (sessionCount < 28) {
      label = ProgressionLabel.baseLoading;
      currentTier = 1;
    }

    if (delta >= 2) {
      final regressUnits = delta.clamp(1, 3);
      progressIndex = (progressIndex - regressUnits).clamp(0, 999999);
      streak = 0;
      label = ProgressionLabel.punishedRegression;
      currentTier = (currentTier - 1).clamp(1, 3);
      tierLockExpiry = now.add(const Duration(hours: 48));
    }

    if (label != ProgressionLabel.punishedRegression && sessionCount >= 28) {
      label = ProgressionLabel.normal;
    }

    state = ProgressionState(
      currentProgressIndex: progressIndex,
      currentStreak: streak,
      lastActiveDate: lastDate,
      label: label,
      tierLockExpiry: tierLockExpiry,
      completedSessionCount: sessionCount,
      maxStreak: maxStreak,
      currentTier: currentTier,
    );
  }

  int _daysBetween(DateTime a, DateTime b) => daysBetween(a, b);

  Future<void> checkInOnStartup() async {
    await _loadFromDb();
  }

  Future<void> completeSession(List<String> exerciseIds) async {
    final isar = await IsarService().db;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final session = DailySession()
      ..date = today
      ..isCompleted = true
      ..isWeatherSkip = false
      ..completedExerciseIds = exerciseIds
      ..userNotes = null
      ..performanceMetrics = '{}';

    await isar.writeTxn(() async {
      await isar.dailySessions.put(session);
    });

    final userState = await isar.userStates.where().anyId().findFirst();
    final newStreak = state.currentStreak + 1;
    final newMaxStreak = newStreak > state.maxStreak ? newStreak : state.maxStreak;
    final newCount = state.completedSessionCount + 1;
    final newTier = calculateTier(newCount);

    if (userState == null) {
      final newState = UserState()
        ..currentProgressIndex = state.currentProgressIndex + 1
        ..currentStreak = newStreak
        ..lastActiveDate = today
        ..historicalAILogs = []
        ..userName = ''
        ..userAge = 0
        ..userWeight = 0
        ..userHeight = 0
        ..fitnessLevel = ''
        ..goals = ''
        ..limitations = ''
        ..aiGeneratedPlan = '';
      await isar.writeTxn(() async {
        await isar.userStates.put(newState);
      });
    } else {
      await isar.writeTxn(() async {
        userState.currentProgressIndex = state.currentProgressIndex + 1;
        userState.currentStreak = newStreak;
        userState.lastActiveDate = today;
        await isar.userStates.put(userState);
      });
    }

    ProgressionLabel label = ProgressionLabel.activeProgression;
    if (newCount < 28) {
      label = ProgressionLabel.baseLoading;
    }

    state = ProgressionState(
      currentProgressIndex: state.currentProgressIndex + 1,
      currentStreak: newStreak,
      lastActiveDate: today,
      label: label,
      tierLockExpiry: state.tierLockExpiry,
      completedSessionCount: newCount,
      maxStreak: newMaxStreak,
      currentTier: newTier,
    );
    FirestoreService().save(isar);
  }

  Future<void> activateWeatherSkip() async {
    state = state.copyWith(
      label: ProgressionLabel.weatherSkipActive,
    );
  }

  Future<void> saveWeatherSkipSession() async {
    final isar = await IsarService().db;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final weatherIds = RemoteConfigService()
        .config
        .weatherExercises
        .take(3)
        .toList();

    final session = DailySession()
      ..date = today
      ..isCompleted = true
      ..isWeatherSkip = true
      ..completedExerciseIds = weatherIds
      ..userNotes = null
      ..performanceMetrics = '{}';

    await isar.writeTxn(() async {
      await isar.dailySessions.put(session);
    });

    final userState = await isar.userStates.where().anyId().findFirst();
    if (userState == null) {
      final newState = UserState()
        ..currentProgressIndex = state.currentProgressIndex
        ..currentStreak = state.currentStreak
        ..lastActiveDate = today
        ..historicalAILogs = []
        ..userName = ''
        ..userAge = 0
        ..userWeight = 0
        ..userHeight = 0
        ..fitnessLevel = ''
        ..goals = ''
        ..limitations = ''
        ..aiGeneratedPlan = '';
      await isar.writeTxn(() async {
        await isar.userStates.put(newState);
      });
    } else {
      await isar.writeTxn(() async {
        userState.lastActiveDate = today;
        await isar.userStates.put(userState);
      });
    }

    state = ProgressionState(
      currentProgressIndex: state.currentProgressIndex,
      currentStreak: state.currentStreak,
      lastActiveDate: today,
      label: ProgressionLabel.normal,
      tierLockExpiry: state.tierLockExpiry,
      completedSessionCount: state.completedSessionCount,
      maxStreak: state.maxStreak,
      currentTier: state.currentTier,
    );
    FirestoreService().save(isar);
  }

  Future<List<WorkoutConfiguration>> getActiveExercises() async {
    final isar = await IsarService().db;
    final isWeatherSkip = state.label == ProgressionLabel.weatherSkipActive;
    final count = state.completedSessionCount;

    // Get recently completed exercise IDs for rotation
    final allSessions = await isar.dailySessions
        .where()
        .anyDate()
        .findAll();
    final recentIds = <String>{};
    // Collect exercise IDs from the last 5 completed sessions
    final completed = allSessions.where((s) => s.isCompleted).toList();
    completed.sort((a, b) => b.date.compareTo(a.date));
    for (final s in completed.take(5)) {
      recentIds.addAll(s.completedExerciseIds);
    }

    if (isWeatherSkip) {
      return isar.workoutConfigurations
          .filter()
          .categoryEqualTo('mobility')
          .sortByExerciseId()
          .findAll();
    }

    Future<List<WorkoutConfiguration>> byCategory(String cat) async {
      final exercises = await isar.workoutConfigurations
          .filter()
          .categoryEqualTo(cat)
          .sortByExerciseId()
          .findAll();
      exercises.shuffle();
      // Sort: exercises NOT in recentIds come first (less recently done)
      exercises.sort((a, b) {
        final aRecent = recentIds.contains(a.exerciseId) ? 1 : 0;
        final bRecent = recentIds.contains(b.exerciseId) ? 1 : 0;
        return aRecent.compareTo(bRecent);
      });
      return exercises;
    }

    final mobility = await byCategory('mobility');
    final walking = await byCategory('walking');
    final endurance = await byCategory('endurance');
    final machines = await byCategory('strength_machine');
    final bodyweight = await byCategory('bodyweight');
    final weights = await byCategory('strength_weights');
    final cooldown = await byCategory('cooldown');

    // Phase 0: Walking Foundation (sessions 0-9)
    if (count < 10) {
      return [
        ...mobility.take(2),
        ...walking.take(2),
        ...cooldown.take(1),
      ];
    }

    // Phase 1: Machine Introduction (sessions 10-19)
    if (count < 20) {
      return [
        ...mobility.take(2),
        ...walking.take(1),
        ...machines.take(2),
        ...cooldown.take(1),
      ];
    }

    // Phase 2: Building (sessions 20-29)
    if (count < 30) {
      return [
        ...mobility.take(2),
        ...endurance.take(1),
        ...machines.take(3),
        ...cooldown.take(1),
      ];
    }

    // Phase 3: Intermediate (sessions 30-39)
    if (count < 40) {
      return [
        ...mobility.take(2),
        ...endurance.take(1),
        ...machines.take(2),
        ...bodyweight.take(1),
        ...cooldown.take(1),
      ];
    }

    // Phase 4: Advanced (sessions 40+)
    return [
      ...mobility.take(3),
      ...endurance.take(1),
      ...machines.take(2),
      ...weights.take(2),
      ...cooldown.take(2),
    ];
  }

  Future<WorkoutConfiguration> getRandomExercise(String category, {String? excludeId}) async {
    final isar = await IsarService().db;
    final all = await isar.workoutConfigurations
        .filter()
        .categoryEqualTo(category)
        .sortByExerciseId()
        .findAll();
    all.shuffle();
    if (excludeId != null) {
      final filtered = all.where((e) => e.exerciseId != excludeId).toList();
      if (filtered.isNotEmpty) return filtered.first;
    }
    return all.first;
  }

  Future<void> saveAIBriefing(String briefing) async {
    final isar = await IsarService().db;
    final userState = await isar.userStates.where().anyId().findFirst();
    if (userState != null) {
      await isar.writeTxn(() async {
        userState.historicalAILogs.add(briefing);
        userState.lastBriefingDate = DateTime.now();
        userState.lastBriefingText = briefing;
        await isar.userStates.put(userState);
      });
    }
  }
}

final progressionNotifierProvider =
    NotifierProvider<ProgressionNotifier, ProgressionState>(
  ProgressionNotifier.new,
);
