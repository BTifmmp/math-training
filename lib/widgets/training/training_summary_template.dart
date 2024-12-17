import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';

class SummaryTemplate extends StatelessWidget {
  final TrainingImageConfig imageConfig;
  final String title;
  final List<String> additionalInfo;
  final List<Widget> trainingResultInfo;
  final Function() onPlayAgain;

  const SummaryTemplate(
      {super.key,
      required this.imageConfig,
      required this.title,
      required this.additionalInfo,
      required this.trainingResultInfo,
      required this.onPlayAgain});

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
              Card.filled(
                color: imageConfig.color,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imageConfig.imgPath,
                    width: 55,
                    height: 55,
                    color: const Color.fromARGB(255, 22, 22, 22),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 35, fontWeight: FontWeight.w600, height: 1.3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              for (var text in additionalInfo)
                Text(text,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300)),
              const Spacer(flex: 1),
              SizedBox(
                width: 250,
                child: Card.filled(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: trainingResultInfo,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.9)),
                onPressed: onPlayAgain,
                child: Container(
                  width: 200,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Text(
                    'Play Again',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontWeight: FontWeight.w400),
                  ),
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
