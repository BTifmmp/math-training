part of 'speed_training_cubit.dart';

@immutable
sealed class SpeedTrainingState {}

final class SpeedTrainingInitial extends SpeedTrainingState {}

final class SpeedTrainingStartCount extends SpeedTrainingState {
  final int startCount;

  SpeedTrainingStartCount({required this.startCount});
}

final class SpeedTrainingRunning extends SpeedTrainingState {
  final Stopwatch stopwatch;
  final int currentTaskIndex;
  final int totalTasksNumber;

  SpeedTrainingRunning(
      {required this.currentTaskIndex,
      required this.totalTasksNumber,
      required this.stopwatch});

  SpeedTrainingRunning copywith({
    int? currentTaskIndex,
    int? totalTasksNumber,
    Stopwatch? stopwatch,
  }) {
    return SpeedTrainingRunning(
      currentTaskIndex: currentTaskIndex ?? this.currentTaskIndex,
      totalTasksNumber: totalTasksNumber ?? this.totalTasksNumber,
      stopwatch: stopwatch ?? this.stopwatch,
    );
  }
}
