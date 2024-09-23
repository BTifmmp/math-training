import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'count_down_state.dart';

class CountDownCubit extends Cubit<CountDownState> {
  Timer? _countDownTimer;

  CountDownCubit({required int count}) : super(CountDownCounting(count: count));

  void start() {
    _countDownTimer?.cancel();

    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state is CountDownCounting) {
        var countingState = state as CountDownCounting;
        if (countingState.count == 1) {
          _countDownTimer?.cancel();
          emit(CountDownFinished());
        } else {
          emit(CountDownCounting(count: countingState.count - 1));
        }
      } else {
        _countDownTimer?.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _countDownTimer?.cancel();
    return super.close();
  }
}
