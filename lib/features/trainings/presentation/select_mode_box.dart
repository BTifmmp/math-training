import 'package:flutter/material.dart';

class TrainingSelectModeBox extends StatefulWidget {
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
  State<TrainingSelectModeBox> createState() => _TrainingSelectModeBoxState();
}

class _TrainingSelectModeBoxState extends State<TrainingSelectModeBox> {
  double _scale = 1;
  int _duration = 50;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: _duration),
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => {
          setState(() {
            _scale = 0.97;
            _duration = 0;
          })
        },
        onTapUp: (_) => {
          setState(() {
            _scale = 1;
            _duration = 50;
          })
        },
        onTapCancel: () => {
          setState(() {
            _scale = 1;
            _duration = 50;
          })
        },
        child: Card.filled(
            // color: Theme.of(context).colorScheme.surfaceContainerHigh,
            color: Colors.transparent,
            shadowColor: Colors.black,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
