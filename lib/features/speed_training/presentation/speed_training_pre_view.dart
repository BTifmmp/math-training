import 'package:flutter/material.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';

class SpeedTrainingPreView extends StatelessWidget {
  const SpeedTrainingPreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.cyan,
      body: Center(
        child: FilledButton(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpeedTrainingPage()))
                },
            child: const Text('Play')),
      ),
    );
  }
}
