import 'package:math_training/database/models/training_types.dart';

class GameTime {
  final GameType type;
  final int time;

  GameTime({required this.type, required this.time});

  Map<String, Object?> toJson() {
    return {
      'type': type.index,
      'time': time,
    };
  }

  factory GameTime.fromDatabaseJson(Map<String, dynamic> data) {
    return GameTime(
      type: GameType.values[data['type']],
      time: data['time'],
    );
  }
}
