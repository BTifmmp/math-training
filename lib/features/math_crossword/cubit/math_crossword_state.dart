part of 'math_crossword_cubit.dart';

@immutable
sealed class MathCrosswordState {}

final class MathCrosswordInitial extends MathCrosswordState {}

final class MathCrosswordGenerated extends MathCrosswordState {
  final BoardMatrix matrix;
  MathCrosswordGenerated({required this.matrix});
}

final class MathCrossWordFinished extends MathCrosswordState {}
