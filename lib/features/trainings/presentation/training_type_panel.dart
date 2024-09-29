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
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            child: Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
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
          ..._dividedModeBoxes(context),
        ],
      ),
    );
  }
}
