import 'package:math_training/features/statictics/domain/memory_training_stats.dart';
import 'package:math_training/features/statictics/domain/speed_training_stats.dart';
import 'package:math_training/features/statictics/domain/statistics.dart';

class StatisticRepository {
  Stream<Statistics> getStatistics() async* {}

  Future<void> saveSpeedTraining(SpeedTrainingStats stats) async {}

  Future<void> saveMemoryTraining(MemoryTrainingStats stats) async {}
}
