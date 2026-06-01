import 'package:isar/isar.dart';

part 'user_state.g.dart';

@collection
class UserState {
  Id id = Isar.autoIncrement;

  late int currentProgressIndex;

  late int currentStreak;

  late DateTime lastActiveDate;

  late List<String> historicalAILogs;

  late String userName;

  late int userAge;

  late double userWeight;

  late double userHeight;

  late String fitnessLevel;

  late String goals;

  late String limitations;

  late String aiGeneratedPlan;

  DateTime? lastBriefingDate;

  String? lastBriefingText;
}
