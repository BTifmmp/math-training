import 'package:flutter/material.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_view.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/widgets/training/training_summary_template.dart';

class MentalTrainingSummaryView extends StatelessWidget {
  final bool isAnswerCorrect;
  final num correctAnswer;
  final TrainingConfig trainingConfig;
  final MentalTrainingType type;
  const MentalTrainingSummaryView({
    super.key,
    required this.isAnswerCorrect,
    required this.trainingConfig,
    required this.correctAnswer,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SummaryTemplate(
        imageConfig: TrainingImageConfig.fromMentalType(type),
        title: trainingConfig.title,
        additionalInfo: [
          'Difficulty: ${trainingConfig.diffcultyText}',
        ],
        trainingResultInfo: [
          Text(
            isAnswerCorrect ? 'Correct Answer' : 'Incorrect Answer',
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.1,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '${!isAnswerCorrect ? 'Correct answer' : 'Answer'}: ${correctAnswer.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
        onPlayAgain: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MentalTrainingPage(
                trainingConfig: trainingConfig,
                type: type,
              ),
            ),
          );
        });
  }
}
