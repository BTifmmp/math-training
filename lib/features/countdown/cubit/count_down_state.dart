part of 'count_down_cubit.dart';

@immutable
sealed class CountDownState {}

final class CountDownCounting extends CountDownState {
  final int count;

  CountDownCounting({required this.count});
}

final class CountDownFinished extends CountDownState {}
