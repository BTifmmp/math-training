import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:math_training/features/board/domain/board_box.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/utils/generation.dart';
import 'package:meta/meta.dart';

part 'math_crossword_state.dart';

class BuildingMatrices {
  final List<List<List<Operation>>> operationsMatrix;
  final List<List<num>> resultsMatrix;
  final List<List<num>> answersMatrix;

  BuildingMatrices(
      {required this.operationsMatrix,
      required this.resultsMatrix,
      required this.answersMatrix});
}

class MathCrosswordCubit extends Cubit<MathCrosswordState> {
  MathCrosswordCubit() : super(MathCrosswordInitial());

  static const int upperLimit = 40;
  BuildingMatrices? buildingMatrices;

  void generateCrossword(GameSize size) {
    buildingMatrices = _generateBuildingMatrices(size);
    BoardMatrix matrix = _computeBoardMatrix(buildingMatrices!, size);
    emit(MathCrosswordGenerated(matrix: matrix));
  }

  void submitAnswer(num answer, int id) {}

  BuildingMatrices _generateBuildingMatrices(GameSize size) {
    int sizeVal = size == GameSize.standard ? 2 : 3;
    final rng = Random();

    final operationsMatrix = List<List<List<Operation>>>.generate(
      sizeVal,
      (_) => List<List<Operation>>.generate(
        sizeVal,
        (_) => List<Operation>.generate(
          sizeVal,
          (_) => Operation.addition,
        ),
      ),
    );

    final numbersHorizontalMatrix = List<List<num>>.generate(
      sizeVal,
      (_) => List<num>.generate(
        sizeVal,
        (_) => 0,
      ),
    );

    final numbersVerticalMatrix = List<List<num>>.generate(
      sizeVal,
      (_) => List<num>.generate(
        sizeVal,
        (_) => 0,
      ),
    );

    final answersMatrix = List<List<num>>.generate(
      sizeVal,
      (_) => List<num>.generate(
        sizeVal,
        (_) => 0,
      ),
    );

    for (int i = 0; i < sizeVal; i++) {
      for (int j = 0; j < sizeVal; j++) {
        num? numTop = i > 0 ? numbersVerticalMatrix[i - 1][j] : null;
        num? numLeft = j > 0 ? numbersHorizontalMatrix[i][j - 1] : null;
        Operation? opTop = i > 0 ? operationsMatrix[i - 1][j][0] : null;
        Operation? opLeft = j > 0 ? operationsMatrix[i][j - 1][1] : null;

        if (numLeft == null) {
          if (numTop == null) {
            // Both null
            answersMatrix[i][j] = 20 + rng.nextInt(upperLimit - 20);
            numbersHorizontalMatrix[i][j] = answersMatrix[i][j];
            numbersVerticalMatrix[i][j] = answersMatrix[i][j];
          } else {
            // Only top num exists
            var res = _performOperation(numTop, opTop!);
            answersMatrix[i][j] = res.$1;
            numbersHorizontalMatrix[i][j] = res.$2;
            numbersVerticalMatrix[i][j] = res.$2;
          }
        } else {
          if (numTop == null) {
            // Only left num exists
            var res = _performOperation(numLeft, opLeft!);
            answersMatrix[i][j] = res.$1;
            numbersHorizontalMatrix[i][j] = res.$2;
            numbersVerticalMatrix[i][j] = res.$2;
          } else {
            if (opLeft == Operation.substraction &&
                opTop == Operation.substraction) {
              var res = _performOperation(
                  min(numLeft, numTop), Operation.substraction);
              answersMatrix[i][j] = res.$1;
              numbersHorizontalMatrix[i][j] = numLeft - res.$1;
              numbersVerticalMatrix[i][j] = numTop - res.$1;
            } else if (opTop == Operation.substraction) {
              var res = _performOperation(numTop, Operation.substraction);
              answersMatrix[i][j] = res.$1;
              numbersHorizontalMatrix[i][j] = numLeft + res.$1;
              numbersVerticalMatrix[i][j] = res.$2;
            } else if (opLeft == Operation.substraction) {
              var res = _performOperation(numLeft, Operation.substraction);
              answersMatrix[i][j] = res.$1;
              numbersHorizontalMatrix[i][j] = res.$2;
              numbersVerticalMatrix[i][j] = numTop + res.$1;
            } else {
              var res =
                  _performOperation(max(numLeft, numTop), Operation.addition);
              answersMatrix[i][j] = res.$1;
              numbersHorizontalMatrix[i][j] = numLeft + res.$1;
              numbersVerticalMatrix[i][j] = numTop + res.$1;
            }
          }
        }

        operationsMatrix[i][j] = [
          _findNextOperations(numbersVerticalMatrix[i][j]),
          _findNextOperations(numbersHorizontalMatrix[i][j])
        ];
      }
    }

    final resultsMatrix = List<List<num>>.generate(
      2,
      (_) => List<num>.generate(
        sizeVal,
        (_) => 0,
      ),
    );

    for (int i = 0; i < sizeVal; i++) {
      resultsMatrix[0][i] = numbersHorizontalMatrix[i][sizeVal - 1];
      resultsMatrix[1][i] = numbersVerticalMatrix[sizeVal - 1][i];
    }

    return BuildingMatrices(
        operationsMatrix: operationsMatrix,
        answersMatrix: answersMatrix,
        resultsMatrix: resultsMatrix);
  }

  BoardMatrix _computeBoardMatrix(BuildingMatrices matrices, GameSize size) {
    int sizeVal = size == GameSize.standard ? 5 : 7;
    BoardMatrix matrix = List<List<BoardBoxInfo>>.generate(
      sizeVal,
      (_) => List<BoardBoxInfo>.generate(
        sizeVal,
        (_) => BoardBoxInfo.empty(),
      ),
    );

    for (int i = 0; i < matrices.answersMatrix.length; i++) {
      for (int j = 0; j < matrices.answersMatrix.length; j++) {
        int putFillableRow = i * 2;
        int putFillableCol = j * 2;

        matrix[putFillableRow][putFillableCol] =
            BoardBoxInfo.fillable(i * 10 + j);

        if (i < matrices.answersMatrix.length - 1) {
          matrix[putFillableRow + 1][putFillableCol] =
              BoardBoxInfo.filledStatic(
                  _operatioToString(matrices.operationsMatrix[i][j][0]));
        }
        if (j < matrices.answersMatrix.length - 1) {
          matrix[putFillableRow][putFillableCol + 1] =
              BoardBoxInfo.filledStatic(
                  _operatioToString(matrices.operationsMatrix[i][j][1]));
        }
      }
    }

    for (int i = 0; i < matrices.resultsMatrix[0].length; i++) {
      matrix[i * 2][sizeVal - 2] = BoardBoxInfo.filledStatic('=');
      matrix[i * 2][sizeVal - 1] =
          BoardBoxInfo.filledStatic(matrices.resultsMatrix[0][i].toString());
      matrix[sizeVal - 2][i * 2] = BoardBoxInfo.filledStatic('=');
      matrix[sizeVal - 1][i * 2] =
          BoardBoxInfo.filledStatic(matrices.resultsMatrix[1][i].toString());
    }

    return matrix;
  }

  String _operatioToString(Operation operation) {
    switch (operation) {
      case Operation.addition:
        return '+';
      case Operation.substraction:
        return '\u2212';
      default:
        return 'invalid';
    }
  }

  Operation _findNextOperations(num number) {
    if (Random().nextDouble() < 0.5) {
      return Operation.addition;
    } else {
      return Operation.substraction;
    }
  }

  (num, num) _performOperation(num previousNumber, Operation operation) {
    switch (operation) {
      case Operation.addition:
        num nextNum = generateNextAdd(upperLimit, false);
        return (nextNum, previousNumber + nextNum);
      case Operation.substraction:
        num nextNum = generateNextSubstract(previousNumber, upperLimit, false);
        return (nextNum, previousNumber - nextNum);
      default:
        return (0, 0);
    }
  }
}
