import 'package:flutter/material.dart';

class TrainingTypePanel extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color? color;
  final List<Widget> modeBoxes;
  const TrainingTypePanel(
      {super.key,
      required this.modeBoxes,
      required this.title,
      required this.imagePath,
      this.color});

  List<Widget> _dividedModeBoxes(BuildContext context) {
    List<Widget> result = [];
    for (Widget box in modeBoxes) {
      result.add(box);
      result.add(Divider(
        indent: 20,
        endIndent: 20,
        height: 0,
        color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
      ));
    }

    result.removeLast();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Row(
            children: [
              Card.filled(
                color: color ?? Theme.of(context).colorScheme.surfaceContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imagePath,
                    width: 45,
                    height: 45,
                    color: const Color.fromARGB(255, 22, 22, 22),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Card.filled(
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Column(
            children: [
              ..._dividedModeBoxes(context),
            ],
          ),
        ),
      ],
    );
  }
}
