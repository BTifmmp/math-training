import 'package:flutter/material.dart';

class TrainingSelectModeBox extends StatelessWidget {
  final String title;
  final String description;
  final GestureTapCallback onTap;

  const TrainingSelectModeBox({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
      splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
