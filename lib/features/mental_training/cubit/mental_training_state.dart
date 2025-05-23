part of 'mental_training_cubit.dart';

enum AnswerStatus { correct, incorrect, waiting }

@immutable
sealed class MentalTrainingState {
  final int totalTasksNumber;
  const MentalTrainingState({required this.totalTasksNumber});
}

final class MentalTrainingInitial extends MentalTrainingState {
  const MentalTrainingInitial({required super.totalTasksNumber});
}

final class MentalTrainingRunning extends MentalTrainingState {
  final String currentTaskText;
  final int currentTaskIndex;

  const MentalTrainingRunning({
    required this.currentTaskText,
    required this.currentTaskIndex,
    required super.totalTasksNumber,
  });

  MentalTrainingRunning copywith({
    String? currentTaskText,
    int? currentTaskIndex,
    int? totalTasksNumber,
  }) {
    return MentalTrainingRunning(
      currentTaskText: currentTaskText ?? this.currentTaskText,
      currentTaskIndex: currentTaskIndex ?? this.currentTaskIndex,
      totalTasksNumber: totalTasksNumber ?? this.totalTasksNumber,
    );
  }
}

final class MentalTrainingWaitingForAnswer extends MentalTrainingState {
  final AnswerStatus answerStatus;
  final int availableTries;
  const MentalTrainingWaitingForAnswer(
      {required this.answerStatus,
      required this.availableTries,
      required super.totalTasksNumber});
}

final class MentalTrainingFinished extends MentalTrainingState {
  final bool isAnswerCorrect;
  final num correctAnswer;
  final TrainingConfig trainingConfig;

  const MentalTrainingFinished(
      {required this.trainingConfig,
      required this.correctAnswer,
      required this.isAnswerCorrect,
      required super.totalTasksNumber});
}
