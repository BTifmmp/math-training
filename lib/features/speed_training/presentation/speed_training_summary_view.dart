import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/utils/duration_formatter.dart';

class SpeedTrainingSummaryView extends StatelessWidget {
  final TrainingConfig trainingConfig;
  final Duration time;

  const SpeedTrainingSummaryView(
      {super.key, required this.trainingConfig, required this.time});

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
              const Text('Best time: 00:00',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              const Spacer(flex: 1),
              SizedBox(
                width: 250,
                child: Card.filled(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        const Text('Your time',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            )),
                        Text(formatDuration(time),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 35,
                              fontWeight: FontWeight.w400,
                            )),
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
