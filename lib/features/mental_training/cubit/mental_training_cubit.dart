import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/features/mental_training/cubit/mental_task_generation.dart';
part 'mental_training_state.dart';

typedef MentalTrainingTask = ({List<String> text, num answer});

class MentalTrainingCubit extends Cubit<MentalTrainingState> {
  static const int totalTasksNumber = 10;

  final TrainingConfig trainingConfig;

  Timer? _timer;
  MentalTrainingTask? _task;

  MentalTrainingCubit({required this.trainingConfig})
      : super(const MentalTrainingInitial(totalTasksNumber: totalTasksNumber));

  void start() {
    _task = _generateTask();

    emit(MentalTrainingRunning(
        currentTaskText: _task?.text[0] ?? 'error',
        currentTaskIndex: 0,
        totalTasksNumber: totalTasksNumber));

    // Keep emitting steps of task till whole task have been emiited
    _timer?.cancel();
    _timer = Timer.periodic(trainingConfig.mentalTrainingDelay, (_) {
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

  void submitAnswer(String answer) {
    if (state is MentalTrainingWaitingForAnswer) {
      final answerState = (state as MentalTrainingWaitingForAnswer);
      if ((num.parse(answer) - _task!.answer).abs() < 0.001) {
        emit(MentalTrainingFinished(
            correctAnswer: _task?.answer ?? 0,
            isAnswerCorrect: true,
            totalTasksNumber: totalTasksNumber,
            trainingConfig: trainingConfig));
      } else if (answer.length >=
          _task!.answer
              .toStringAsFixed(1)
              .replaceAll(RegExp(r'\.0$'), '')
              .length) {
        // If avaible tires are equal to 1 it means that
        // this answer was the last one allowed
        if (answerState.availableTries == 1) {
          emit(MentalTrainingFinished(
              correctAnswer: _task?.answer ?? 0,
              isAnswerCorrect: false,
              totalTasksNumber: totalTasksNumber,
              trainingConfig: trainingConfig));
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
    Operation operation;
    final rng = Random();

    num answer = max(
        rng.nextInt(
            max(trainingConfig.addSubstractMax, trainingConfig.multDivMax)),
        1);
    List<String> text = ['Start with $answer'];

    final availableIncreasingOperations = [
      if (trainingConfig.availableOperations.contains(Operation.addition))
        Operation.addition,
      if (trainingConfig.availableOperations.contains(Operation.multiplication))
        Operation.multiplication
    ];

    final availableLoweringOperations = [
      if (trainingConfig.availableOperations.contains(Operation.substraction))
        Operation.substraction,
      if (trainingConfig.availableOperations.contains(Operation.division))
        Operation.division
    ];

    for (int i = 0; i < totalTasksNumber; i++) {
      if (answer <= 10) {
        operation = availableIncreasingOperations[
            rng.nextInt(availableIncreasingOperations.length)];
      } else if (answer >
          max(trainingConfig.addSubstractMax,
              pow(trainingConfig.multDivMax, 2))) {
        operation = availableLoweringOperations[
            rng.nextInt(availableLoweringOperations.length)];
      } else {
        operation = trainingConfig.availableOperations[
            rng.nextInt(trainingConfig.availableOperations.length)];
      }

      switch (operation) {
        case Operation.addition:
          final number = generateNextAdd(trainingConfig.addSubstractMax,
              trainingConfig.allowAddSubstractFractions);
          answer += number;
          text.add('Add \n$number');
        case Operation.substraction:
          final number = generateNextSubstract(
              answer,
              trainingConfig.addSubstractMax,
              trainingConfig.allowAddSubstractFractions);
          answer -= number;
          text.add('Substract\n$number');
        case Operation.multiplication:
          final number =
              generateNextMultiplication(answer, trainingConfig.multDivMax);
          answer *= number;
          text.add('Multiply\n$number');
        case Operation.division:
          final number =
              generateNextDivision(answer, trainingConfig.multDivMax);
          answer /= number;
          text.add('Divide by\n$number');
        case _:
      }
    }
    return (text: text, answer: answer);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
