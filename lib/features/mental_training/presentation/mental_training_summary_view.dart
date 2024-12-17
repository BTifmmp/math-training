import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';

class MentalTrainingSummaryView extends StatelessWidget {
  final bool isAnswerCorrect;
  final num correctAnswer;
  final TrainingConfig trainingConfig;
  const MentalTrainingSummaryView(
      {super.key,
      required this.isAnswerCorrect,
      required this.trainingConfig,
      required this.correctAnswer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 2),
              Text(
                trainingConfig.title,
                style: const TextStyle(
                    fontSize: 35, fontWeight: FontWeight.w600, height: 1.3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text('Difficulty: ${trainingConfig.diffcultyText}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300)),
              const Text('Correct answers: 0',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              const Spacer(flex: 1),
              SizedBox(
                width: 250,
                child: Card.filled(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          isAnswerCorrect
                              ? 'Correct Answer'
                              : 'Incorrect Answer',
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
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: Theme.of(context).colorScheme.onSurface),
                alignment: Alignment.center,
                width: 250,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  'Play Again',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
