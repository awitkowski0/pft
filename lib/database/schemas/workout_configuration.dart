import 'package:isar/isar.dart';

part 'workout_configuration.g.dart';

@collection
class WorkoutConfiguration {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String exerciseId;

  late String name;

  late String category;

  late int progressionTier;

  late String instructions;

  late String feelRight;

  late String feelWrong;

  late String restTime;

  late String sets;

  late String reps;

  String? duration;

  String? distance;

  late String notes;
}
