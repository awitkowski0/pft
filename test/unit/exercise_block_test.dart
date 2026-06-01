import 'package:flutter_test/flutter_test.dart';
import 'package:pft/state/session_notifier.dart';

void main() {
  group('ExerciseBlock', () {
    final base = ExerciseBlock(
      id: 'push_up',
      name: 'Push Up',
      description: 'Standard push up',
      target: 'REPS: 10-15',
      category: 'bodyweight',
      feelRight: 'Chest engages at bottom',
      feelWrong: 'Elbows flare out',
      restTime: '60 sec',
      sets: '3',
      reps: '12',
      notes: 'Keep core tight',
      isCompleted: false,
      status: 'upNext',
    );

    test('default constructor values', () {
      final block = ExerciseBlock(
        id: 'test',
        name: 'Test',
        description: 'Desc',
        target: 'TARGET: TEST',
      );
      expect(block.id, 'test');
      expect(block.category, '');
      expect(block.feelRight, '');
      expect(block.feelWrong, '');
      expect(block.restTime, '');
      expect(block.sets, '');
      expect(block.reps, '');
      expect(block.notes, '');
      expect(block.isCompleted, false);
      expect(block.status, 'upNext');
    });

    test('copyWith changes no fields returns same', () {
      final copy = base.copyWith();
      expect(copy.id, base.id);
      expect(copy.name, base.name);
      expect(copy.description, base.description);
      expect(copy.target, base.target);
      expect(copy.category, base.category);
      expect(copy.isCompleted, base.isCompleted);
      expect(copy.status, base.status);
    });

    test('copyWith overrides id', () {
      final copy = base.copyWith(id: 'diamond_push_up');
      expect(copy.id, 'diamond_push_up');
      expect(copy.name, base.name);
    });

    test('copyWith overrides name', () {
      final copy = base.copyWith(name: 'Diamond Push Up');
      expect(copy.name, 'Diamond Push Up');
      expect(copy.id, base.id);
    });

    test('copyWith toggles isCompleted', () {
      final copy = base.copyWith(isCompleted: true);
      expect(copy.isCompleted, true);
      expect(copy.status, base.status);
    });

    test('copyWith changes status', () {
      final copy = base.copyWith(status: 'activeTask');
      expect(copy.status, 'activeTask');
      expect(copy.isCompleted, false);
    });

    test('copyWith overrides feelRight', () {
      final copy = base.copyWith(feelRight: 'Feel the burn');
      expect(copy.feelRight, 'Feel the burn');
    });

    test('copyWith overrides feelWrong', () {
      final copy = base.copyWith(feelWrong: 'Don\'t arch back');
      expect(copy.feelWrong, 'Don\'t arch back');
    });

    test('copyWith overrides all string fields', () {
      final copy = base.copyWith(
        id: 'new_id',
        name: 'New Name',
        description: 'New desc',
        target: 'NEW TARGET',
        category: 'strength',
        feelRight: 'Right',
        feelWrong: 'Wrong',
        restTime: '90 sec',
        sets: '4',
        reps: '10',
        notes: 'New notes',
        isCompleted: true,
        status: 'coolDown',
      );
      expect(copy.id, 'new_id');
      expect(copy.name, 'New Name');
      expect(copy.description, 'New desc');
      expect(copy.target, 'NEW TARGET');
      expect(copy.category, 'strength');
      expect(copy.feelRight, 'Right');
      expect(copy.feelWrong, 'Wrong');
      expect(copy.restTime, '90 sec');
      expect(copy.sets, '4');
      expect(copy.reps, '10');
      expect(copy.notes, 'New notes');
      expect(copy.isCompleted, true);
      expect(copy.status, 'coolDown');
    });
  });

  group('SessionState', () {
    test('default constructor creates empty state', () {
      final state = SessionState();
      expect(state.exercises, isEmpty);
      expect(state.startedAt, DateTime.fromMillisecondsSinceEpoch(0));
      expect(state.sessionComplete, false);
      expect(state.isWeatherSession, false);
    });

    test('copyWith changes exercises', () {
      final state = SessionState();
      final exercises = [
        ExerciseBlock(
          id: 'test',
          name: 'Test',
          description: 'Desc',
          target: 'TARGET',
        ),
      ];
      final copy = state.copyWith(exercises: exercises);
      expect(copy.exercises.length, 1);
      expect(copy.exercises.first.id, 'test');
      expect(copy.sessionComplete, false);
    });

    test('copyWith marks session complete', () {
      final state = SessionState();
      final copy = state.copyWith(sessionComplete: true);
      expect(copy.sessionComplete, true);
    });

    test('copyWith sets weather session', () {
      final state = SessionState();
      final copy = state.copyWith(isWeatherSession: true);
      expect(copy.isWeatherSession, true);
    });

    test('copyWith preserves startedAt', () {
      final state = SessionState();
      final copy = state.copyWith(sessionComplete: true);
      expect(copy.startedAt, state.startedAt);
    });

    test('multiple copyWith calls compose', () {
      final state = SessionState();
      final copy1 = state.copyWith(isWeatherSession: true);
      final copy2 = copy1.copyWith(sessionComplete: true);
      expect(copy2.isWeatherSession, true);
      expect(copy2.sessionComplete, true);
    });
  });
}
