import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:math_training/features/board/domain/board_box.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:meta/meta.dart';

part 'magic_square_state.dart';

class MagicSquareCubit extends Cubit<MagicSquareState> {
  MagicSquareCubit() : super(MagicSquareInitial());
  late int magicSum;
  late List<List<int>> generatedSquareMatrix;
  late List<List<int>> userAnswersMatrix;

  void generateMagicSquare(GameSize size) {
    if (size == GameSize.small) {
      _generateMagicSmall();
    } else {
      _generateMagicBig();
    }
    userAnswersMatrix = List<List<int>>.generate(
      generatedSquareMatrix.length,
      (_) => List<int>.filled(generatedSquareMatrix.length, 0),
    );
    BoardMatrix matrix = _computeBoardMatrix(size);
    emit(MagicSquareGenerated(matrix: matrix));
  }

  void submitAnswer(int answer, int id) {
    var row = id ~/ 10;
    var col = id % 10;

    try {
      userAnswersMatrix[row][col] = answer;
      bool areAllCorrect = _checkAnswers();
      if (areAllCorrect) {
        emit(MagicSquareFinished());
      }
    } on Exception catch (_) {
      // userAnswersMatrix is not initialized yet
    }
  }

  bool _checkAnswers() {
    int rowSum = 0;
    int colSum = 0;
    // Rows and columns
    for (int i = 0; i < userAnswersMatrix.length; i++) {
      rowSum = 0;
      colSum = 0;
      for (int j = 0; j < userAnswersMatrix.length; j++) {
        rowSum += userAnswersMatrix[i][j];
        colSum += userAnswersMatrix[j][i];
      }

      if (rowSum != magicSum || colSum != magicSum) {
        return false;
      }
    }

    // Diagonals
    int diagonalSum1 = 0;
    int diagonalSum2 = 0;
    int lastIndex = userAnswersMatrix.length - 1;
    for (int i = 0; i < userAnswersMatrix.length; i++) {
      diagonalSum1 += userAnswersMatrix[i][i];
      diagonalSum2 += userAnswersMatrix[i][lastIndex - i];
    }
    if (diagonalSum1 != magicSum || diagonalSum2 != magicSum) {
      return false;
    }

    return true;
  }

  void _generateMagicSmall() {
    var rng = Random();

    // Generate a, b, c values where
    // 3c is magic sum,
    int c = 5 + rng.nextInt(15);
    int a = 1 + rng.nextInt(c ~/ 2 - 1);

    int minb = a + 1;
    int maxb = c - a - 1;

    // Compute a potential `b`
    int b = rng.nextInt(maxb - minb + 1) + minb;

    // Adjust `b` if it ends up being `2 * a`
    if (b == 2 * a) {
      b = (b + 1 <= maxb) ? b + 1 : b - 1;
    }

    magicSum = c * 3;

    generatedSquareMatrix = [
      [c - b, c + a + b, c - a],
      [c - a + b, c, c + a - b],
      [c + a, c - a - b, c + b],
    ];

    // Perform rotations and flip randomly to increase variability
    int rotations = rng.nextInt(4);
    for (int i = 0; i < rotations; i++) {
      _rotateBy90Degree();
    }

    bool flip = rng.nextDouble() < 0.5;
    if (flip) {
      _flipHorizontally();
    }
  }

  void _generateMagicBig() {
    List<int> values = List.generate(4, (i) => i * 10);
    values.shuffle();
    int a = values[0];
    int b = values[1];
    int c = values[2];
    int d = values[3];

    List<int> values2 = List.generate(10, (i) => i);
    values2.shuffle();
    int a2 = values2[0];
    int b2 = values2[1];
    int c2 = values2[2];
    int d2 = values2[3];

    generatedSquareMatrix = [
      [a + a2, b + b2, c + c2, d + d2],
      [d + c2, c + d2, b + a2, a + b2],
      [b + d2, a + c2, d + b2, c + a2],
      [c + b2, d + a2, a + d2, b + c2],
    ];

    magicSum = a + a2 + b + b2 + c + c2 + d + d2;
  }

  BoardMatrix _computeBoardMatrix(GameSize size) {
    int sizeVal = size == GameSize.small ? 3 : 4;

    var answeredAnswers = _pickAnsweredAnswers(size);

    BoardMatrix matrix = List<List<BoardBoxInfo>>.generate(
      sizeVal,
      (i) => List<BoardBoxInfo>.generate(sizeVal, (j) {
        int singleIntegerIndex = i * generatedSquareMatrix.length + j;

        if (answeredAnswers.contains(singleIntegerIndex)) {
          userAnswersMatrix[i][j] = generatedSquareMatrix[i][j];
          return BoardBoxInfo.filledStatic(
              generatedSquareMatrix[i][j].toString());
        } else {
          return BoardBoxInfo.fillable(i * 10 + j);
        }
      }),
    );

    return matrix;
  }

  List<int> _pickAnsweredAnswers(GameSize size) {
    // Picks 3 random fields or 8
    if (size == GameSize.small) {
      List<List<int>> validCombinations = [
        [0, 1, 2],
        [0, 1, 4],
        [0, 1, 5],
        [0, 1, 6],
        [0, 1, 8],
        [0, 2, 3],
        [0, 2, 5],
        [0, 2, 7],
        [0, 3, 4],
        [0, 3, 6],
        [0, 3, 7],
        [0, 3, 8],
        [0, 5, 6],
        [0, 5, 8],
        [0, 6, 7],
        [0, 7, 8],
        [1, 2, 3],
        [1, 2, 4],
        [1, 2, 6],
        [1, 2, 8],
        [1, 3, 6],
        [1, 5, 8],
        [1, 6, 8],
        [2, 3, 6],
        [2, 3, 8],
        [2, 4, 5],
        [2, 5, 6],
        [2, 5, 7],
        [2, 5, 8],
        [2, 6, 7],
        [2, 7, 8],
        [3, 4, 6],
        [3, 6, 8],
        [3, 7, 8],
        [4, 5, 8],
        [4, 6, 7],
        [4, 7, 8],
        [5, 6, 7],
        [5, 6, 8],
        [6, 7, 8]
      ];
      return validCombinations[Random().nextInt(validCombinations.length)];
    } else {
      List<List<int>> validCombinations = [
        [0, 1, 2, 3, 4, 6, 11, 15],
        [0, 1, 2, 3, 4, 13, 14, 15],
        [0, 1, 2, 3, 5, 7, 8, 12],
        [0, 1, 2, 3, 7, 12, 13, 14],
        [0, 1, 2, 3, 8, 9, 12, 14],
        [0, 1, 2, 3, 8, 9, 13, 15],
        [0, 1, 2, 3, 8, 11, 13, 14],
        [0, 1, 2, 3, 10, 11, 12, 14],
        [0, 1, 2, 3, 10, 11, 13, 15],
        [0, 1, 2, 4, 8, 10, 11, 15],
        [0, 1, 2, 4, 8, 10, 14, 15],
        [0, 1, 2, 5, 6, 7, 10, 11],
        [0, 1, 2, 5, 6, 10, 11, 14],
        [0, 1, 2, 5, 7, 9, 10, 12],
        [0, 1, 2, 7, 8, 9, 10, 12],
        [0, 1, 2, 7, 8, 10, 13, 15],
        [0, 1, 2, 11, 12, 13, 14, 15],
        [0, 1, 3, 4, 5, 6, 10, 14],
        [0, 1, 3, 4, 6, 9, 13, 15],
        [0, 1, 3, 5, 6, 9, 12, 13],
        [0, 1, 3, 5, 7, 8, 11, 15],
        [0, 1, 3, 5, 7, 9, 11, 14],
        [0, 1, 3, 6, 7, 11, 14, 15],
        [0, 1, 4, 5, 9, 10, 11, 12],
        [0, 1, 4, 6, 7, 9, 12, 15],
        [0, 1, 4, 7, 8, 11, 12, 15],
        [0, 1, 4, 8, 9, 12, 14, 15],
        [0, 1, 5, 6, 7, 9, 12, 13],
        [0, 1, 5, 7, 11, 13, 14, 15],
        [0, 1, 5, 9, 10, 11, 12, 13],
        [0, 1, 5, 9, 10, 12, 13, 15],
        [0, 2, 3, 4, 5, 8, 12, 13],
        [0, 2, 3, 4, 6, 8, 10, 13],
        [0, 2, 3, 4, 6, 8, 11, 12],
        [0, 2, 3, 5, 6, 7, 9, 13],
        [0, 2, 3, 5, 6, 10, 14, 15],
        [0, 2, 3, 5, 7, 10, 12, 14],
        [0, 2, 4, 5, 12, 13, 14, 15],
        [0, 2, 4, 6, 7, 8, 12, 15],
        [0, 2, 4, 7, 8, 10, 13, 15],
        [0, 2, 4, 7, 8, 11, 12, 14],
        [0, 2, 5, 6, 7, 9, 13, 15],
        [0, 2, 5, 7, 8, 11, 13, 15],
        [0, 2, 5, 7, 8, 13, 14, 15],
        [0, 2, 6, 7, 8, 9, 10, 15],
        [0, 2, 6, 7, 12, 13, 14, 15],
        [0, 2, 6, 8, 9, 10, 13, 15],
        [0, 2, 6, 9, 11, 12, 14, 15],
        [0, 3, 4, 5, 6, 7, 9, 12],
        [0, 3, 4, 5, 6, 7, 9, 13],
        [0, 3, 4, 5, 6, 7, 10, 14],
        [0, 3, 4, 5, 6, 7, 10, 15],
        [0, 3, 4, 5, 6, 8, 10, 13],
        [0, 3, 4, 7, 8, 11, 12, 13],
        [0, 3, 4, 7, 8, 11, 14, 15],
        [0, 3, 4, 8, 10, 11, 12, 14],
        [0, 3, 5, 6, 7, 9, 11, 14],
        [0, 3, 5, 8, 10, 11, 12, 13],
        [0, 3, 6, 8, 9, 11, 14, 15],
        [0, 3, 7, 8, 9, 11, 13, 15],
        [0, 4, 5, 6, 11, 12, 13, 14],
        [0, 4, 5, 7, 11, 13, 14, 15],
        [0, 4, 5, 8, 9, 10, 11, 14],
        [0, 4, 5, 8, 9, 10, 13, 14],
        [0, 4, 7, 8, 10, 12, 14, 15],
        [0, 4, 9, 11, 12, 13, 14, 15],
        [0, 5, 6, 7, 8, 9, 12, 13],
        [0, 5, 6, 7, 8, 9, 13, 15],
        [0, 5, 6, 9, 11, 12, 13, 14],
        [0, 5, 8, 9, 10, 11, 12, 15],
        [1, 2, 3, 4, 5, 6, 8, 9],
        [1, 2, 3, 4, 6, 9, 10, 15],
        [1, 2, 3, 4, 9, 10, 11, 15],
        [1, 2, 3, 4, 9, 11, 12, 14],
        [1, 2, 3, 5, 6, 8, 9, 13],
        [1, 2, 3, 7, 8, 9, 11, 12],
        [1, 2, 3, 7, 9, 11, 12, 13],
        [1, 2, 3, 8, 12, 13, 14, 15],
        [1, 2, 4, 5, 6, 8, 9, 12],
        [1, 2, 4, 7, 12, 13, 14, 15],
        [1, 2, 5, 6, 7, 10, 11, 15],
        [1, 3, 4, 5, 6, 10, 12, 14],
        [1, 3, 4, 5, 7, 11, 12, 15],
        [1, 3, 4, 5, 9, 10, 11, 12],
        [1, 3, 4, 5, 12, 13, 14, 15],
        [1, 3, 4, 6, 8, 11, 12, 14],
        [1, 3, 4, 6, 11, 12, 13, 14],
        [1, 3, 4, 7, 8, 11, 13, 15],
        [1, 3, 4, 7, 9, 11, 12, 14],
        [1, 3, 5, 8, 10, 12, 13, 15],
        [1, 3, 5, 9, 10, 11, 12, 14],
        [1, 3, 6, 7, 12, 13, 14, 15],
        [1, 4, 5, 6, 7, 10, 11, 15],
        [1, 4, 5, 9, 10, 13, 14, 15],
        [1, 4, 6, 8, 9, 10, 12, 15],
        [1, 4, 6, 8, 10, 12, 14, 15],
        [1, 5, 8, 9, 10, 11, 12, 15],
        [1, 5, 9, 10, 11, 12, 14, 15],
        [2, 3, 4, 5, 6, 10, 14, 15],
        [2, 3, 4, 5, 7, 10, 12, 15],
        [2, 3, 4, 6, 8, 12, 13, 14],
        [2, 3, 4, 7, 8, 11, 12, 15],
        [2, 3, 6, 7, 8, 9, 10, 15],
        [2, 3, 6, 8, 9, 10, 14, 15],
        [2, 3, 6, 9, 10, 12, 14, 15],
        [2, 3, 7, 10, 11, 12, 13, 15],
        [2, 4, 5, 6, 7, 8, 9, 12],
        [2, 5, 7, 9, 10, 11, 12, 15],
        [2, 5, 7, 9, 11, 12, 13, 15],
        [2, 6, 7, 9, 10, 12, 13, 14],
        [2, 6, 8, 9, 10, 11, 12, 15],
        [2, 6, 8, 9, 10, 12, 13, 15],
        [3, 4, 5, 6, 10, 11, 12, 14],
        [3, 4, 5, 6, 10, 11, 14, 15],
        [3, 4, 6, 7, 8, 12, 13, 14],
        [3, 4, 7, 9, 11, 12, 13, 15],
        [3, 5, 6, 7, 8, 13, 14, 15],
        [3, 5, 6, 8, 10, 13, 14, 15],
        [3, 6, 7, 8, 9, 10, 11, 13],
        [3, 6, 7, 9, 10, 11, 13, 14],
        [3, 6, 8, 9, 10, 11, 12, 15],
        [3, 7, 8, 10, 12, 13, 14, 15],
        [4, 5, 8, 9, 10, 13, 14, 15],
        [6, 7, 9, 10, 11, 12, 13, 14]
      ]; // 8 answers
      return validCombinations[Random().nextInt(validCombinations.length)];
    }
  }

  void _rotateBy90Degree() {
    for (int i = 0; i < generatedSquareMatrix.length; i++) {
      for (int j = i; j < generatedSquareMatrix.length; j++) {
        var temp = generatedSquareMatrix[i][j];
        generatedSquareMatrix[i][j] = generatedSquareMatrix[j][i];
        generatedSquareMatrix[j][i] = temp;
      }
    }

    for (int i = 0; i < generatedSquareMatrix.length; i++) {
      generatedSquareMatrix[i] = generatedSquareMatrix[i].reversed.toList();
    }
  }

  void _flipHorizontally() {
    int length = generatedSquareMatrix.length;
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length ~/ 2; j++) {
        var temp = generatedSquareMatrix[i][j];
        generatedSquareMatrix[i][j] = generatedSquareMatrix[i][length - 1 - j];
        generatedSquareMatrix[i][length - 1 - j] = temp;
      }
    }
  }
}
