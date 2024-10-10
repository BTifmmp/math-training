import 'package:math_training/features/trainings/domain/training_types.dart';

class MentalTrainingStats {
  final MentalTrainingType type;
  final int numberOfCorrectAnswers;

  MentalTrainingStats({
    required this.type,
    required this.numberOfCorrectAnswers,
  });

  Map<String, Object?> toMap() {
    return {
      'type': type,
      'correct': numberOfCorrectAnswers,
    };
  }

  factory MentalTrainingStats.fromDatabaseJson(Map<String, dynamic> data) =>
      MentalTrainingStats(
        type: data['type'],
        numberOfCorrectAnswers: data['correct'],
      );
}
