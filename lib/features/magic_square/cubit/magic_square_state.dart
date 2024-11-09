part of 'magic_square_cubit.dart';

@immutable
sealed class MagicSquareState {}

final class MagicSquareInitial extends MagicSquareState {}

final class MagicSquareGenerated extends MagicSquareState {
  final BoardMatrix matrix;
  MagicSquareGenerated({required this.matrix});
}

final class MagicSquareFinished extends MagicSquareState {}
