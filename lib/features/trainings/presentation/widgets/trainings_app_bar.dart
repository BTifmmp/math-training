import 'package:flutter/material.dart';

class TrainingsAppBar extends StatelessWidget {
  final String title;
  const TrainingsAppBar({
    super.key,
    required bool visible,
    required this.title,
  }) : _visible = visible;

  final bool _visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.05),
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
