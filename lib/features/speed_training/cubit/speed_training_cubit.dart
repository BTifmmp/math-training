import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'speed_training_state.dart';

typedef SpeedTrainingTask = ({String text, num answer});

class SpeedTrainingCubit extends Cubit<SpeedTrainingState> {
  static const int totalTasksNumber = 5;
  num? _expectedAnswer;

  SpeedTrainingCubit()
      : super(const SpeedTrainingInitial(totalTasksNumber: totalTasksNumber));

  void start() {
    final task = _generateTask();
    _expectedAnswer = task.answer;
    emit(SpeedTrainingRunning(
        answerStatus: AnswerStatus.waiting,
        currentTaskText: task.text,
        currentTaskIndex: 1,
        totalTasksNumber: totalTasksNumber));
  }

  void submitAnswer(num answer) {
    if (answer == _expectedAnswer) {
      if (state is SpeedTrainingRunning) {
        if ((state as SpeedTrainingRunning).currentTaskIndex ==
            totalTasksNumber) {
          emit(const SpeedTrainingFinished(totalTasksNumber: totalTasksNumber));
          return;
        }

        emit((state as SpeedTrainingRunning)
            .copywith(answerStatus: AnswerStatus.correct));

        final task = _generateTask();
        _expectedAnswer = task.answer;
        emit(SpeedTrainingRunning(
            answerStatus: AnswerStatus.waiting,
            currentTaskText: task.text,
            currentTaskIndex:
                (state as SpeedTrainingRunning).currentTaskIndex + 1,
            totalTasksNumber: totalTasksNumber));
      }
    } else if (answer.toString().length >= _expectedAnswer!.toString().length) {
      if (state is SpeedTrainingRunning) {
        emit((state as SpeedTrainingRunning)
            .copywith(answerStatus: AnswerStatus.incorrect));
      }
    }
  }

  SpeedTrainingTask _generateTask() {
    var rng = Random();
    num num1 = rng.nextInt(21);
    num num2 = rng.nextInt(21);

    num answer = num1 + num2;
    String text = '$num1 + $num2';

    return (text: text, answer: answer);
  }
}
