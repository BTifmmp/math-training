import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class Countdown extends StatelessWidget {
  final int count;
  const Countdown({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: AnimatedFlipCounter(
          value: count,
          textStyle: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
