import 'package:flutter_test/flutter_test.dart';
import 'package:pft/core/progression_math.dart';
import 'package:pft/database/schemas/daily_session.dart';

void main() {
  group('daysBetween', () {
    test('same day returns 0', () {
      final a = DateTime(2026, 6, 1);
      expect(daysBetween(a, a), 0);
    });

    test('consecutive days returns 1', () {
      final a = DateTime(2026, 6, 1);
      final b = DateTime(2026, 6, 2);
      expect(daysBetween(a, b), 1);
    });

    test('ignores time component', () {
      final a = DateTime(2026, 6, 1, 23, 59);
      final b = DateTime(2026, 6, 2, 0, 1);
      expect(daysBetween(a, b), 1);
    });

    test('seven days apart returns 7', () {
      final a = DateTime(2026, 6, 1);
      final b = DateTime(2026, 6, 8);
      expect(daysBetween(a, b), 7);
    });
  });

  group('calculateMaxStreak', () {
    test('empty list returns 0', () {
      expect(calculateMaxStreak([]), 0);
    });

    test('single session returns 1', () {
      final sessions = [
        DailySession()..date = DateTime(2026, 6, 1),
      ];
      expect(calculateMaxStreak(sessions), 1);
    });

    test('two consecutive days returns 2', () {
      final sessions = [
        DailySession()..date = DateTime(2026, 6, 1),
        DailySession()..date = DateTime(2026, 6, 2),
      ];
      expect(calculateMaxStreak(sessions), 2);
    });

    test('gap resets streak', () {
      final sessions = [
        DailySession()..date = DateTime(2026, 6, 1),
        DailySession()..date = DateTime(2026, 6, 2),
        DailySession()..date = DateTime(2026, 6, 5),
      ];
      expect(calculateMaxStreak(sessions), 2);
    });

    test('unsorted input still finds correct streak', () {
      final sessions = [
        DailySession()..date = DateTime(2026, 6, 3),
        DailySession()..date = DateTime(2026, 6, 1),
        DailySession()..date = DateTime(2026, 6, 2),
      ];
      expect(calculateMaxStreak(sessions), 3);
    });
  });

  group('calculateTier', () {
    test('0 sessions is tier 1', () {
      expect(calculateTier(0), 1);
    });

    test('27 sessions is tier 1', () {
      expect(calculateTier(27), 1);
    });

    test('28 sessions is tier 2', () {
      expect(calculateTier(28), 2);
    });

    test('55 sessions is tier 2', () {
      expect(calculateTier(55), 2);
    });

    test('56 sessions is tier 3', () {
      expect(calculateTier(56), 3);
    });

    test('100 sessions is tier 3', () {
      expect(calculateTier(100), 3);
    });
  });

  group('phaseIndex', () {
    test('session 0-9 is phase 0', () {
      expect(phaseIndex(0), 0);
      expect(phaseIndex(5), 0);
      expect(phaseIndex(9), 0);
    });

    test('session 10-19 is phase 1', () {
      expect(phaseIndex(10), 1);
      expect(phaseIndex(15), 1);
      expect(phaseIndex(19), 1);
    });

    test('session 20-29 is phase 2', () {
      expect(phaseIndex(20), 2);
      expect(phaseIndex(25), 2);
      expect(phaseIndex(29), 2);
    });

    test('session 30-39 is phase 3', () {
      expect(phaseIndex(30), 3);
      expect(phaseIndex(35), 3);
      expect(phaseIndex(39), 3);
    });

    test('session 40+ is phase 4', () {
      expect(phaseIndex(40), 4);
      expect(phaseIndex(50), 4);
      expect(phaseIndex(999), 4);
    });
  });

  group('phaseName', () {
    test('phase 0 name', () {
      expect(phaseName(0), 'Walking Foundation');
    });

    test('phase 1 name', () {
      expect(phaseName(10), 'Machine Introduction');
    });

    test('phase 2 name', () {
      expect(phaseName(20), 'Building');
    });

    test('phase 3 name', () {
      expect(phaseName(30), 'Intermediate');
    });

    test('phase 4 name', () {
      expect(phaseName(40), 'Advanced');
    });
  });

  group('nextPhaseAt', () {
    test('phase 0 next boundary is 10', () {
      expect(nextPhaseAt(0), 10);
      expect(nextPhaseAt(9), 10);
    });

    test('phase 1 next boundary is 20', () {
      expect(nextPhaseAt(10), 20);
      expect(nextPhaseAt(19), 20);
    });

    test('phase 2 next boundary is 30', () {
      expect(nextPhaseAt(20), 30);
      expect(nextPhaseAt(29), 30);
    });

    test('phase 3 next boundary is 40', () {
      expect(nextPhaseAt(30), 40);
      expect(nextPhaseAt(39), 40);
    });

    test('phase 4 returns 0 (no next phase)', () {
      expect(nextPhaseAt(40), 0);
      expect(nextPhaseAt(100), 0);
    });
  });

  group('nextPhaseName', () {
    test('phase 0 next name', () {
      expect(nextPhaseName(0), 'Machine Introduction');
    });

    test('phase 1 next name', () {
      expect(nextPhaseName(10), 'Building');
    });

    test('phase 2 next name', () {
      expect(nextPhaseName(20), 'Intermediate');
    });

    test('phase 3 next name', () {
      expect(nextPhaseName(30), 'Advanced');
    });

    test('phase 4 returns empty', () {
      expect(nextPhaseName(40), '');
    });
  });

  group('phaseDescription', () {
    test('phase 0 description', () {
      expect(phaseDescription(0), 'Walking 2 miles/day, mobility drills');
    });

    test('phase 1 description', () {
      expect(phaseDescription(1), 'Machines + walking, estimated weights');
    });

    test('phase 2 description', () {
      expect(phaseDescription(2), 'Cardio + machines, progressive loads');
    });

    test('phase 3 description', () {
      expect(phaseDescription(3), 'Dumbbells, bodyweight, machines');
    });

    test('phase 4 description', () {
      expect(phaseDescription(4), 'Compound lifts, barbell, full intensity');
    });

    test('invalid index returns empty', () {
      expect(phaseDescription(-1), '');
      expect(phaseDescription(5), '');
    });
  });

  group('phaseAtSession', () {
    test('positions 0-9', () {
      expect(phaseAtSession(0), 'Walking Foundation');
      expect(phaseAtSession(9), 'Walking Foundation');
    });

    test('positions 10-19', () {
      expect(phaseAtSession(10), 'Machine Intro');
      expect(phaseAtSession(19), 'Machine Intro');
    });

    test('positions 20-29', () {
      expect(phaseAtSession(20), 'Building');
      expect(phaseAtSession(29), 'Building');
    });

    test('positions 30-39', () {
      expect(phaseAtSession(30), 'Intermediate');
      expect(phaseAtSession(39), 'Intermediate');
    });

    test('positions 40+', () {
      expect(phaseAtSession(40), 'Advanced');
      expect(phaseAtSession(100), 'Advanced');
    });
  });
}
