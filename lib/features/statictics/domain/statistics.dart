import 'package:math_training/constants/training_types.dart';
import 'package:math_training/features/statictics/domain/memory_training_stats.dart';
import 'package:math_training/features/statictics/domain/speed_training_stats.dart';

class Statistics {
  final Map<SpeedTrainingType, SpeedTrainingStats> speedTrainingStats;
  final Map<MemoryTrainingType, MemoryTrainingStats> memoryTrainingStats;

  Statistics(
      {required this.speedTrainingStats, required this.memoryTrainingStats});
}
