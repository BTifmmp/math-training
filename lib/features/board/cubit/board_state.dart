part of 'board_cubit.dart';

@immutable
sealed class BoardState {}

final class BoardSelectedController extends BoardState {
  final NumberInputController? controller;
  BoardSelectedController({this.controller});
}
