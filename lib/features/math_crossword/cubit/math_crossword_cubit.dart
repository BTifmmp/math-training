import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:math_training/features/board/domain/board_box.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/utils/generation.dart';
import 'package:meta/meta.dart';

part 'math_crossword_state.dart';

class BuildingMatrices {
  final List<List<List<Operation>>> operationsMatrix;
  final List<List<int>> resultsMatrix;
  final List<List<int>> answersMatrix;

  BuildingMatrices(
      {required this.operationsMatrix,
      required this.resultsMatrix,
      required this.answersMatrix});
}

class MathCrosswordCubit extends Cubit<MathCrosswordState> {
  MathCrosswordCubit() : super(MathCrosswordInitial());

  static const int upperLimit = 40;
  late BuildingMatrices buildingMatrices;
  late List<List<int>> userAnswersMatrix;

  void generateCrossword(GameSize size) {
    buildingMatrices = _generateBuildingMatrices(size);
    userAnswersMatrix = List<List<int>>.generate(
      buildingMatrices.answersMatrix.length,
      (_) => List<int>.filled(buildingMatrices.answersMatrix.length, 0),
    );
    BoardMatrix matrix = _computeBoardMatrix(size);
    emit(MathCrosswordGenerated(matrix: matrix));
  }

  void submitAnswer(int answer, int id) {
    var row = id ~/ 10;
    var col = id % 10;
    try {
      userAnswersMatrix[row][col] = answer;
      bool areAllCorrect = _checkAnswers();
      if (areAllCorrect) {
        emit(MathCrossWordFinished());
      }
    } on Exception catch (_) {
      // buildingMatrices or userAnswersMatrix is not initialized yet
    }
  }

  bool _checkAnswers() {
    for (int i = 0; i < buildingMatrices.answersMatrix.length; i++) {
      for (int j = 0; j < buildingMatrices.answersMatrix.length; j++) {
        if (userAnswersMatrix[i][j] != buildingMatrices.answersMatrix[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  BuildingMatrices _generateBuildingMatrices(GameSize size) {
    int sizeVal = size == GameSize.small ? 2 : 3;

    final operationsMatrix = List<List<List<Operation>>>.generate(
        sizeVal,
        (_) => List<List<Operation>>.filled(
            sizeVal, [Operation.addition, Operation.addition]));

    final numbersHorizontalMatrix =
        List<List<int>>.generate(sizeVal, (_) => List<int>.filled(sizeVal, 0));

    final numbersVerticalMatrix =
        List<List<int>>.generate(sizeVal, (_) => List<int>.filled(sizeVal, 0));

    final answersMatrix =
        List<List<int>>.generate(sizeVal, (_) => List<int>.filled(sizeVal, 0));

    for (int i = 0; i < sizeVal; i++) {
      for (int j = 0; j < sizeVal; j++) {
        int? numTop = i > 0 ? numbersVerticalMatrix[i - 1][j] : null;
        int? numLeft = j > 0 ? numbersHorizontalMatrix[i][j - 1] : null;
        Operation? opTop = i > 0 ? operationsMatrix[i - 1][j][0] : null;
        Operation? opLeft = j > 0 ? operationsMatrix[i][j - 1][1] : null;

        if (numLeft == null) {
          if (numTop == null) {
            // Both null
            answersMatrix[i][j] = 20 + Random().nextInt(upperLimit - 20);
            numbersHorizontalMatrix[i][j] = answersMatrix[i][j];
            numbersVerticalMatrix[i][j] = answersMatrix[i][j];
          } else {
            // Only top num exists
            var res = _performOperation(numTop, opTop!);
            answersMatrix[i][j] = res.$1;
            numbersHorizontalMatrix[i][j] = res.$1;
            numbersVerticalMatrix[i][j] = res.$2;
          }
        } else {
          if (numTop == null) {
            // Only left num exists
            var res = _performOperation(numLeft, opLeft!);
            answersMatrix[i][j] = res.$1;
            numbersHorizontalMatrix[i][j] = res.$2;
            numbersVerticalMatrix[i][j] = res.$1;
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

        operationsMatrix[i][j] = [_findNextOperations(), _findNextOperations()];
      }
    }

    List<List<int>> resultsMatrix = _computeResultsMatrix(
        sizeVal, numbersHorizontalMatrix, numbersVerticalMatrix);

    return BuildingMatrices(
        operationsMatrix: operationsMatrix,
        answersMatrix: answersMatrix,
        resultsMatrix: resultsMatrix);
  }

  BoardMatrix _computeBoardMatrix(GameSize size) {
    int sizeVal = size == GameSize.small ? 5 : 7;
    BoardMatrix matrix = List<List<BoardBoxInfo>>.generate(
      sizeVal,
      (_) => List<BoardBoxInfo>.generate(
        sizeVal,
        (_) => BoardBoxInfo.empty(),
      ),
    );

    var answeredAnswers = _pickAnsweredAnswers(size);

    for (int i = 0; i < buildingMatrices.answersMatrix.length; i++) {
      for (int j = 0; j < buildingMatrices.answersMatrix.length; j++) {
        int putFillableRow = i * 2;
        int putFillableCol = j * 2;

        int singleIntegerIndex = i * buildingMatrices.answersMatrix.length + j;

        if (answeredAnswers.contains(singleIntegerIndex)) {
          matrix[putFillableRow][putFillableCol] = BoardBoxInfo.filledStatic(
              buildingMatrices.answersMatrix[i][j].toString());
          userAnswersMatrix[i][j] = buildingMatrices.answersMatrix[i][j];
        } else {
          matrix[putFillableRow][putFillableCol] =
              BoardBoxInfo.fillable(i * 10 + j);
        }

        if (i < buildingMatrices.answersMatrix.length - 1) {
          matrix[putFillableRow + 1][putFillableCol] =
              BoardBoxInfo.filledStatic(_operatioToString(
                  buildingMatrices.operationsMatrix[i][j][0]));
        }
        if (j < buildingMatrices.answersMatrix.length - 1) {
          matrix[putFillableRow][putFillableCol + 1] =
              BoardBoxInfo.filledStatic(_operatioToString(
                  buildingMatrices.operationsMatrix[i][j][1]));
        }
      }
    }

    for (int i = 0; i < buildingMatrices.resultsMatrix[0].length; i++) {
      matrix[i * 2][sizeVal - 2] = BoardBoxInfo.filledStatic('=');
      matrix[i * 2][sizeVal - 1] = BoardBoxInfo.filledStatic(
          buildingMatrices.resultsMatrix[0][i].toString());
      matrix[sizeVal - 2][i * 2] = BoardBoxInfo.filledStatic('=');
      matrix[sizeVal - 1][i * 2] = BoardBoxInfo.filledStatic(
          buildingMatrices.resultsMatrix[1][i].toString());
    }

    return matrix;
  }

  List<List<int>> _computeResultsMatrix(
      int sizeVal,
      List<List<int>> numbersHorizontalMatrix,
      List<List<int>> numbersVerticalMatrix) {
    final resultsMatrix = List<List<int>>.generate(
      2,
      (_) => List<int>.generate(
        sizeVal,
        (_) => 0,
      ),
    );

    for (int i = 0; i < sizeVal; i++) {
      resultsMatrix[0][i] = numbersHorizontalMatrix[i][sizeVal - 1];
      resultsMatrix[1][i] = numbersVerticalMatrix[sizeVal - 1][i];
    }
    return resultsMatrix;
  }

  List<int> _pickAnsweredAnswers(GameSize size) {
    var rng = Random();
    if (size == GameSize.small) {
      return [rng.nextInt(4)];
    } else {
      List<List<int>> validCombinations = [
        [0, 1, 3, 4],
        [0, 1, 3, 5],
        [0, 1, 3, 7],
        [0, 1, 3, 8],
        [0, 1, 4, 5],
        [0, 1, 4, 6],
        [0, 1, 4, 8],
        [0, 1, 5, 6],
        [0, 1, 5, 7],
        [0, 1, 6, 7],
        [0, 1, 6, 8],
        [0, 1, 7, 8],
        [0, 2, 3, 4],
        [0, 2, 3, 5],
        [0, 2, 3, 7],
        [0, 2, 3, 8],
        [0, 2, 4, 5],
        [0, 2, 4, 6],
        [0, 2, 4, 8],
        [0, 2, 5, 6],
        [0, 2, 5, 7],
        [0, 2, 6, 7],
        [0, 2, 6, 8],
        [0, 2, 7, 8],
        [0, 3, 4, 7],
        [0, 3, 4, 8],
        [0, 3, 5, 7],
        [0, 3, 5, 8],
        [0, 4, 5, 7],
        [0, 4, 5, 8],
        [0, 4, 6, 7],
        [0, 4, 6, 8],
        [0, 4, 7, 8],
        [0, 5, 6, 7],
        [0, 5, 6, 8],
        [0, 5, 7, 8],
        [1, 2, 3, 4],
        [1, 2, 3, 5],
        [1, 2, 3, 7],
        [1, 2, 3, 8],
        [1, 2, 4, 5],
        [1, 2, 4, 6],
        [1, 2, 4, 8],
        [1, 2, 5, 6],
        [1, 2, 5, 7],
        [1, 2, 6, 7],
        [1, 2, 6, 8],
        [1, 2, 7, 8],
        [1, 3, 4, 6],
        [1, 3, 4, 8],
        [1, 3, 5, 6],
        [1, 3, 5, 8],
        [1, 3, 6, 7],
        [1, 3, 6, 8],
        [1, 3, 7, 8],
        [1, 4, 5, 6],
        [1, 4, 5, 8],
        [1, 5, 6, 7],
        [1, 5, 6, 8],
        [1, 5, 7, 8],
        [2, 3, 4, 6],
        [2, 3, 4, 7],
        [2, 3, 5, 7],
        [2, 3, 6, 7],
        [2, 3, 6, 8],
        [2, 3, 7, 8],
        [2, 4, 5, 6],
        [2, 4, 5, 7],
        [2, 4, 6, 7],
        [2, 4, 6, 8],
        [2, 4, 7, 8],
        [3, 4, 6, 7],
        [3, 4, 6, 8],
        [3, 4, 7, 8],
        [3, 5, 6, 7],
        [3, 5, 6, 8],
        [3, 5, 7, 8],
        [4, 5, 6, 7],
        [4, 5, 6, 8],
        [4, 5, 7, 8]
      ];
      var selectedCombination =
          validCombinations[rng.nextInt(validCombinations.length)];

      return selectedCombination;
    }
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

  Operation _findNextOperations() {
    if (Random().nextDouble() < 0.5) {
      return Operation.addition;
    } else {
      return Operation.substraction;
    }
  }

  (int, int) _performOperation(num previousNumber, Operation operation) {
    switch (operation) {
      case Operation.addition:
        num nextNum = generateNextAdd(upperLimit, false);
        return (nextNum.toInt(), (previousNumber + nextNum).toInt());
      case Operation.substraction:
        num nextNum = generateNextSubstract(previousNumber, upperLimit, false);
        return (nextNum.toInt(), (previousNumber - nextNum).toInt());
      default:
        return (0, 0);
    }
  }
}
