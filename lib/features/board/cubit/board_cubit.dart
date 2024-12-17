import 'package:bloc/bloc.dart';
import 'package:math_training/widgets/number_input/number_input_controller.dart';
import 'package:meta/meta.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardSelectedController(controller: null));

  void changeController(NumberInputController controller) {
    emit(BoardSelectedController(controller: controller));
  }
}
