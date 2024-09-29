import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'mental_training_state.dart';

typedef MentalTrainingTask = ({List<String> text, num answer});

class MentalTrainingCubit extends Cubit<MentalTrainingState> {
  static const int totalTasksNumber = 2;
  static const Duration taskDelay = Duration(milliseconds: 2000);

  Timer? _timer;
  MentalTrainingTask? _task;

  MentalTrainingCubit()
      : super(const MentalTrainingInitial(totalTasksNumber: totalTasksNumber));

  void start() {
    _task = _generateTask();

    emit(MentalTrainingRunning(
        currentTaskText: _task?.text[0] ?? 'error',
        currentTaskIndex: 0,
        totalTasksNumber: totalTasksNumber));

    // Keep emitting steps of task till whole task have been emiited
    _timer?.cancel();
    _timer = Timer.periodic(taskDelay, (_) {
      if (state is MentalTrainingRunning) {
        final runningState = (state as MentalTrainingRunning);
        if (runningState.currentTaskIndex == totalTasksNumber) {
          _timer?.cancel();
          emit(const MentalTrainingWaitingForAnswer(
              availableTries: 3,
              totalTasksNumber: totalTasksNumber,
              answerStatus: AnswerStatus.waiting));
        } else {
          emit(runningState.copywith(
              currentTaskText:
                  _task?.text[runningState.currentTaskIndex + 1] ?? 'error',
              currentTaskIndex: runningState.currentTaskIndex + 1));
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  void submitAnswer(num answer) {
    if (state is MentalTrainingWaitingForAnswer) {
      final answerState = (state as MentalTrainingWaitingForAnswer);
      if (answer == _task?.answer) {
        emit(MentalTrainingFinished(
            correctAnswer: _task?.answer ?? 0,
            isAnswerCorrect: true,
            totalTasksNumber: totalTasksNumber));
      } else if (answer.toString().length >= _task!.answer.toString().length) {
        // If avaible tires are equal to 1 it means that
        // this answer was the last one allowed
        if (answerState.availableTries == 1) {
          emit(MentalTrainingFinished(
              correctAnswer: _task?.answer ?? 0,
              isAnswerCorrect: false,
              totalTasksNumber: totalTasksNumber));
        } else {
          emit(MentalTrainingWaitingForAnswer(
              availableTries: answerState.availableTries - 1,
              totalTasksNumber: totalTasksNumber,
              answerStatus: AnswerStatus.incorrect));
        }
      }
    }
  }

  MentalTrainingTask _generateTask() {
    var rng = Random();
    num num1 = rng.nextInt(21);
    num num2 = rng.nextInt(21);

    num answer = num1 + num2;
    String text = '$num1 + $num2';

    return (
      text: [
        'Start with\n92',
        'Add\n4',
        'Substract\n90',
        'Add\n4',
        'Substract\n90',
        'Add\n4',
        'Substract\n90',
        'Add\n4',
        'Substract\n90',
        'Add\n4',
        'Substract\n90'
      ],
      answer: 123
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
