part of 'speed_training_cubit.dart';

enum AnswerStatus { correct, incorrect, waiting }

@immutable
sealed class SpeedTrainingState {
  final int totalTasksNumber;

  const SpeedTrainingState({required this.totalTasksNumber});
}

final class SpeedTrainingInitial extends SpeedTrainingState {
  const SpeedTrainingInitial({required super.totalTasksNumber});
}

final class SpeedTrainingRunning extends SpeedTrainingState {
  final String currentTaskText;
  final AnswerStatus answerStatus;
  final int currentTaskIndex;

  const SpeedTrainingRunning({
    required this.answerStatus,
    required this.currentTaskText,
    required this.currentTaskIndex,
    required super.totalTasksNumber,
  });

  SpeedTrainingRunning copywith({
    AnswerStatus? answerStatus,
    String? currentTaskText,
    int? currentTaskIndex,
    int? totalTasksNumber,
  }) {
    return SpeedTrainingRunning(
      answerStatus: answerStatus ?? this.answerStatus,
      currentTaskText: currentTaskText ?? this.currentTaskText,
      currentTaskIndex: currentTaskIndex ?? this.currentTaskIndex,
      totalTasksNumber: totalTasksNumber ?? this.totalTasksNumber,
    );
  }
}

final class SpeedTrainingFinished extends SpeedTrainingState {
  const SpeedTrainingFinished({required super.totalTasksNumber});
}
