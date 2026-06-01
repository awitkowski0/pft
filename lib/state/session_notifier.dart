import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/schemas/workout_configuration.dart';

class ExerciseBlock {
  final String id;
  final String name;
  final String description;
  final String target;
  final String category;
  final String feelRight;
  final String feelWrong;
  final String restTime;
  final String sets;
  final String reps;
  final String notes;
  final bool isCompleted;
  final String status;

  const ExerciseBlock({
    required this.id,
    required this.name,
    required this.description,
    required this.target,
    this.category = '',
    this.feelRight = '',
    this.feelWrong = '',
    this.restTime = '',
    this.sets = '',
    this.reps = '',
    this.notes = '',
    this.isCompleted = false,
    this.status = 'upNext',
  });

  ExerciseBlock copyWith({
    String? id,
    String? name,
    String? description,
    String? target,
    String? category,
    String? feelRight,
    String? feelWrong,
    String? restTime,
    String? sets,
    String? reps,
    String? notes,
    bool? isCompleted,
    String? status,
  }) {
    return ExerciseBlock(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      target: target ?? this.target,
      category: category ?? this.category,
      feelRight: feelRight ?? this.feelRight,
      feelWrong: feelWrong ?? this.feelWrong,
      restTime: restTime ?? this.restTime,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      status: status ?? this.status,
    );
  }
}

class SessionState {
  final List<ExerciseBlock> exercises;
  final DateTime startedAt;
  final bool sessionComplete;
  final bool isWeatherSession;

  SessionState()
      : exercises = const [],
        startedAt = DateTime.fromMillisecondsSinceEpoch(0),
        sessionComplete = false,
        isWeatherSession = false;

  SessionState._({
    required this.exercises,
    required this.startedAt,
    this.sessionComplete = false,
    this.isWeatherSession = false,
  });

  SessionState copyWith({
    List<ExerciseBlock>? exercises,
    bool? sessionComplete,
    bool? isWeatherSession,
  }) {
    return SessionState._(
      exercises: exercises ?? this.exercises,
      startedAt: startedAt,
      sessionComplete: sessionComplete ?? this.sessionComplete,
      isWeatherSession: isWeatherSession ?? this.isWeatherSession,
    );
  }
}

class SessionNotifier extends Notifier<SessionState> {
  @override
  SessionState build() {
    return SessionState();
  }

  void startSession(List<WorkoutConfiguration> configs, {bool isWeather = false}) {
    final exercises = configs.map((c) {
      return ExerciseBlock(
        id: c.exerciseId,
        name: c.name,
        description: c.instructions,
        target: _buildTarget(c),
        category: c.category,
        feelRight: c.feelRight,
        feelWrong: c.feelWrong,
        restTime: c.restTime,
        sets: c.sets,
        reps: c.reps,
        notes: c.notes,
        status: 'upNext',
      );
    }).toList();

    if (exercises.isNotEmpty) {
      exercises[0] = exercises[0].copyWith(status: 'activeTask');
      if (exercises.length > 2) {
        exercises[exercises.length - 1] =
            exercises[exercises.length - 1].copyWith(status: 'coolDown');
      }
    }

    state = SessionState._(
      exercises: exercises,
      startedAt: DateTime.now(),
      isWeatherSession: isWeather,
    );
  }

  String _buildTarget(WorkoutConfiguration config) {
    final parts = <String>[];
    if (config.distance != null && config.distance!.isNotEmpty) {
      parts.add('DISTANCE: ${config.distance}');
    }
    if (config.duration != null && config.duration!.isNotEmpty) {
      parts.add('DURATION: ${config.duration}');
    }
    if (config.reps.isNotEmpty) {
      parts.add('REPS: ${config.reps}');
    }
    if (config.sets.isNotEmpty) {
      parts.add('SETS: ${config.sets}');
    }
    if (parts.isNotEmpty) return parts.join(' · ');
    return 'TARGET: ${config.category.toUpperCase()}';
  }

  void toggleExercise(int index) {
    if (index >= state.exercises.length) return;
    final exercises = [...state.exercises];
    final current = exercises[index];
    exercises[index] = current.copyWith(isCompleted: !current.isCompleted);

    if (index + 1 < exercises.length && current.isCompleted == false) {
      if (exercises[index + 1].status == 'upNext') {
        exercises[index + 1] = exercises[index + 1].copyWith(status: 'activeTask');
      }
    }

    final allDone = exercises.every((e) => e.isCompleted);
    state = state.copyWith(
      exercises: exercises,
      sessionComplete: allDone,
    );
  }

  List<String> getCompletedExerciseIds() {
    return state.exercises
        .where((e) => e.isCompleted)
        .map((e) => e.id)
        .toList();
  }

  void replaceSession(List<WorkoutConfiguration> configs, {bool isWeather = false}) {
    final exercises = configs.map((c) {
      return ExerciseBlock(
        id: c.exerciseId,
        name: c.name,
        description: c.instructions,
        target: _buildTarget(c),
        category: c.category,
        feelRight: c.feelRight,
        feelWrong: c.feelWrong,
        restTime: c.restTime,
        sets: c.sets,
        reps: c.reps,
        notes: c.notes,
        status: 'upNext',
      );
    }).toList();

    if (exercises.isNotEmpty) {
      exercises[0] = exercises[0].copyWith(status: 'activeTask');
      if (exercises.length > 2) {
        exercises[exercises.length - 1] =
            exercises[exercises.length - 1].copyWith(status: 'coolDown');
      }
    }

    state = state.copyWith(exercises: exercises, sessionComplete: false);
  }

  void swapExercise(int index, WorkoutConfiguration replacement) {
    if (index >= state.exercises.length) return;
    final exercises = [...state.exercises];
    final block = ExerciseBlock(
      id: replacement.exerciseId,
      name: replacement.name,
      description: replacement.instructions,
      target: _buildTarget(replacement),
      category: replacement.category,
      feelRight: replacement.feelRight,
      feelWrong: replacement.feelWrong,
      restTime: replacement.restTime,
      sets: replacement.sets,
      reps: replacement.reps,
      notes: replacement.notes,
      status: exercises[index].status,
    );
    exercises[index] = block;
    state = state.copyWith(exercises: exercises);
  }

  void appendExercises(List<WorkoutConfiguration> configs) {
    final existing = [...state.exercises];
    final newBlocks = configs.map((c) {
      return ExerciseBlock(
        id: c.exerciseId,
        name: c.name,
        description: c.instructions,
        target: _buildTarget(c),
        category: c.category,
        feelRight: c.feelRight,
        feelWrong: c.feelWrong,
        restTime: c.restTime,
        sets: c.sets,
        reps: c.reps,
        notes: c.notes,
        status: 'upNext',
      );
    }).toList();

    existing.addAll(newBlocks);

    if (existing.length > 2 && existing.last.status != 'coolDown') {
      existing[existing.length - 1] =
          existing[existing.length - 1].copyWith(status: 'coolDown');
    } else if (existing.length == 2 && existing.last.status != 'coolDown') {
      existing[existing.length - 1] =
          existing[existing.length - 1].copyWith(status: 'coolDown');
    }

    state = state.copyWith(exercises: existing, sessionComplete: false);
  }

  void resetSession() {
    state = SessionState();
  }
}

final sessionNotifierProvider =
    NotifierProvider<SessionNotifier, SessionState>(
  SessionNotifier.new,
);
