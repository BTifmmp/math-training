import 'package:math_training/database/models/training_types.dart';

class MentalTrainingStats {
  final MentalTrainingType type;
  final int numberOfCorrectAnswers;

  MentalTrainingStats({
    required this.type,
    required this.numberOfCorrectAnswers,
  });

  Map<String, Object?> toJson() {
    return {
      'type': type.index,
      'correctAnswers': numberOfCorrectAnswers,
    };
  }

  factory MentalTrainingStats.fromDatabaseJson(Map<String, dynamic> data) =>
      MentalTrainingStats(
        type: MentalTrainingType.values[data['type']],
        numberOfCorrectAnswers: data['correctAnswers'],
      );
}
