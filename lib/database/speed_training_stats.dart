import 'package:math_training/features/trainings/domain/training_types.dart';

class SpeedTrainingTime {
  final SpeedTrainingType type;
  final int time;

  SpeedTrainingTime({required this.type, required this.time});

  Map<String, Object?> toJson() {
    return {
      'type': type,
      'time': time,
    };
  }

  factory SpeedTrainingTime.fromDatabaseJson(Map<String, dynamic> data) =>
      SpeedTrainingTime(
        type: data['type'],
        time: data['time'],
      );
}
