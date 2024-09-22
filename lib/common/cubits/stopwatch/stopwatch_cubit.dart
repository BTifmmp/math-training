import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  final _stopwatch = Stopwatch();
  Timer? _updateTimer;

  StopwatchCubit() : super(const StopwatchInitial(timeElapsed: Duration.zero));

  void start() {
    _updateTimer?.cancel();
    _stopwatch.start();
    _updateTimer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      emit(StopwatchRunning(timeElapsed: _stopwatch.elapsed));
    });
  }

  void pause() {
    _updateTimer?.cancel();
    _stopwatch.stop();
    emit(StopwatchPaused(timeElapsed: _stopwatch.elapsed));
  }

  void reset() {
    _updateTimer?.cancel();
    _stopwatch.reset();
    emit(StopwatchPaused(timeElapsed: _stopwatch.elapsed));
  }

  @override
  Future<void> close() {
    _updateTimer?.cancel();

    return super.close();
  }
}
