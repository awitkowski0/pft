import 'package:isar/isar.dart';

part 'daily_session.g.dart';

@collection
class DailySession {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  late bool isCompleted;

  late bool isWeatherSkip;

  late List<String> completedExerciseIds;

  late String performanceMetrics;

  late String? userNotes;
}
