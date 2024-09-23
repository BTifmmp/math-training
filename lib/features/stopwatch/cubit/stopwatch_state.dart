part of 'stopwatch_cubit.dart';

@immutable
sealed class StopwatchState {
  final Duration timeElapsed;

  const StopwatchState({required this.timeElapsed});
}

final class StopwatchInitial extends StopwatchState {
  const StopwatchInitial({required super.timeElapsed});
}

final class StopwatchRunning extends StopwatchState {
  const StopwatchRunning({required super.timeElapsed});
}

final class StopwatchPaused extends StopwatchState {
  const StopwatchPaused({required super.timeElapsed});
}
