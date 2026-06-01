import '../database/schemas/daily_session.dart';

int daysBetween(DateTime a, DateTime b) {
  final aDate = DateTime(a.year, a.month, a.day);
  final bDate = DateTime(b.year, b.month, b.day);
  return bDate.difference(aDate).inDays;
}

int calculateMaxStreak(List<DailySession> sessions) {
  if (sessions.isEmpty) return 0;
  final sorted = List<DailySession>.from(sessions)
    ..sort((a, b) => a.date.compareTo(b.date));
  int maxStreak = 1;
  int currentStreak = 1;
  for (int i = 1; i < sorted.length; i++) {
    final diff = sorted[i].date.difference(sorted[i - 1].date).inDays;
    if (diff == 1) {
      currentStreak++;
      if (currentStreak > maxStreak) maxStreak = currentStreak;
    } else if (diff > 1) {
      currentStreak = 1;
    }
  }
  return maxStreak;
}

int calculateTier(int completedSessions) {
  if (completedSessions < 28) return 1;
  if (completedSessions < 56) return 2;
  return 3;
}

int phaseIndex(int count) {
  if (count < 10) return 0;
  if (count < 20) return 1;
  if (count < 30) return 2;
  if (count < 40) return 3;
  return 4;
}

String phaseName(int count) {
  if (count < 10) return 'Walking Foundation';
  if (count < 20) return 'Machine Introduction';
  if (count < 30) return 'Building';
  if (count < 40) return 'Intermediate';
  return 'Advanced';
}

int nextPhaseAt(int count) {
  if (count < 10) return 10;
  if (count < 20) return 20;
  if (count < 30) return 30;
  if (count < 40) return 40;
  return 0;
}

String nextPhaseName(int count) {
  if (count < 10) return 'Machine Introduction';
  if (count < 20) return 'Building';
  if (count < 30) return 'Intermediate';
  if (count < 40) return 'Advanced';
  return '';
}

String phaseDescription(int idx) {
  switch (idx) {
    case 0:
      return 'Walking 2 miles/day, mobility drills';
    case 1:
      return 'Machines + walking, estimated weights';
    case 2:
      return 'Cardio + machines, progressive loads';
    case 3:
      return 'Dumbbells, bodyweight, machines';
    case 4:
      return 'Compound lifts, barbell, full intensity';
    default:
      return '';
  }
}

String phaseAtSession(int position) {
  if (position < 10) return 'Walking Foundation';
  if (position < 20) return 'Machine Intro';
  if (position < 30) return 'Building';
  if (position < 40) return 'Intermediate';
  return 'Advanced';
}
