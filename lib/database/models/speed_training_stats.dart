import 'package:math_training/database/models/training_types.dart';

class SpeedTrainingTime {
  final SpeedTrainingType type;
  final int time;

  SpeedTrainingTime({required this.type, required this.time});

  Map<String, Object?> toJson() {
    return {
      'type': type.index,
      'time': time,
    };
  }

  factory SpeedTrainingTime.fromDatabaseJson(Map<String, dynamic> data) {
    return SpeedTrainingTime(
      type: SpeedTrainingType.values[data['type']],
      time: data['time'],
    );
  }
}
