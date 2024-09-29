import 'package:flutter/material.dart';

class TrainingTypePanel extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<Widget> modeBoxes;
  const TrainingTypePanel(
      {super.key,
      required this.modeBoxes,
      required this.title,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          ...modeBoxes,
        ],
      ),
    );
  }
}
