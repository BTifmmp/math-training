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
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
      opacity: _visible ? 1 : 0,
      child: Visibility(
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
                    .withOpacity(0.1),
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
