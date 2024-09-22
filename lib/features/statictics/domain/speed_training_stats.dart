import 'package:math_training/constants/training_types.dart';

class SpeedTrainingStats {
  final SpeedTrainingType type;
  final int numberOfPlays;
  final List<int> times;

  SpeedTrainingStats(
    this.type, {
    required this.times,
    required this.numberOfPlays,
  });
}
