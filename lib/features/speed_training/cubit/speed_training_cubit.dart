import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'speed_training_state.dart';

class SpeedTrainingCubit extends Cubit<SpeedTrainingState> {
  static const int countdownDuration = 3;
  static const int totalTasksNumber = 20;

  SpeedTrainingCubit() : super(SpeedTrainingInitial());

  void start() {}
  void submitAnswer() {}
}
