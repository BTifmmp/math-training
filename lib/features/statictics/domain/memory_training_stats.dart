import 'package:math_training/constants/training_types.dart';

class MemoryTrainingStats {
  final MemoryTrainingType type;
  final int numberOfPlays;
  final int numberOfCorrectAnswers;
  final int numberOfIncorrectAnswers;

  MemoryTrainingStats(
      {required this.type,
      required this.numberOfPlays,
      required this.numberOfCorrectAnswers,
      required this.numberOfIncorrectAnswers});
}
