import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_training/utils/generation_common.dart';
import 'package:math_training/features/speed_training/cubit/speed_task_generation.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
part 'speed_training_state.dart';

typedef SpeedTrainingTask = ({String text, num answer});

class SpeedTrainingCubit extends Cubit<SpeedTrainingState> {
  static const int totalTasksNumber = 10;

  final TrainingConfig trainingConfig;
  num? _expectedAnswer;

  SpeedTrainingCubit({required this.trainingConfig})
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

  void submitAnswer(String answer) {
    if (_expectedAnswer == null) return;

    try {
      num.parse(answer);
    } catch (_) {
      return;
    }

    if ((num.parse(answer) - _expectedAnswer!).abs() < 0.001) {
      if (state is SpeedTrainingRunning) {
        if ((state as SpeedTrainingRunning).currentTaskIndex ==
            totalTasksNumber) {
          emit(SpeedTrainingFinished(
              totalTasksNumber: totalTasksNumber,
              trainingConfig: trainingConfig));
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
    } else if (answer.length >=
        _expectedAnswer!
            .toStringAsFixed(1)
            .replaceAll(RegExp(r'\.0$'), '')
            .length) {
      if (state is SpeedTrainingRunning) {
        emit((state as SpeedTrainingRunning)
            .copywith(answerStatus: AnswerStatus.incorrect));
      }
    }
  }

  SpeedTrainingTask _generateTask() {
    final rng = Random();
    final Operation operation = trainingConfig.availableOperations[
        rng.nextInt(trainingConfig.availableOperations.length)];

    String taskText = '';
    num answer = 0;
    switch (operation) {
      case Operation.addition:
        NumberPair pair = generateAddPair(trainingConfig.addSubstractMax,
            trainingConfig.allowAddSubstractFractions);
        taskText =
            '${removeUnnecesaryDecimalZero(pair.$1)} + ${removeUnnecesaryDecimalZero(pair.$2)}';
        answer = pair.$1 + pair.$2;
        break;
      case Operation.substraction:
        NumberPair pair = generateSubstractPair(trainingConfig.addSubstractMax,
            trainingConfig.allowAddSubstractFractions);
        taskText =
            '${removeUnnecesaryDecimalZero(pair.$1)} - ${removeUnnecesaryDecimalZero(pair.$2)}';
        answer = pair.$1 - pair.$2;
        break;
      case Operation.multiplication:
        NumberPair pair = generateMultiplicationPair(trainingConfig.multDivMax);
        taskText = '${pair.$1} \u00d7 ${pair.$2}';
        answer = pair.$1 * pair.$2;
        break;
      case Operation.division:
        NumberPair pair = generateDivisionPair(trainingConfig.multDivMax);
        taskText = '${pair.$1} \u00f7 ${pair.$2}';
        answer = pair.$1 ~/ pair.$2;
        break;
      case Operation.root:
        NumberPair pair = generateRoot(
            trainingConfig.rootPowerMax, trainingConfig.allowRootPowerThirds);

        final String prefix = pair.$2 == 3 ? '\u221B' : '\u221A';
        taskText = '$prefix${pair.$1}';
        answer = pow(pair.$1, 1 / pair.$2);
      case Operation.power:
        NumberPair pair = generatePower(
            trainingConfig.rootPowerMax, trainingConfig.allowRootPowerThirds);

        final String sufix = pair.$2 == 3 ? '\u00B3' : '\u00B2';
        taskText = '${pair.$1}$sufix';
        answer = pow(pair.$1, pair.$2);
    }

    return (text: taskText, answer: answer);
  }
}
