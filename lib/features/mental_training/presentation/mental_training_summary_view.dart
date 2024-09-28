import 'package:flutter/material.dart';

class MentalTrainingSummaryView extends StatelessWidget {
  const MentalTrainingSummaryView({super.key});

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
              const Text(
                'Addition & Substraction',
                style: TextStyle(
                    fontSize: 35, fontWeight: FontWeight.w600, height: 1.3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text('Difficulty: easy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              const Text('Correct answers: 0',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              const Spacer(flex: 1),
              SizedBox(
                width: 250,
                child: Card.filled(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text('Correct Answer',
                            style: TextStyle(
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
