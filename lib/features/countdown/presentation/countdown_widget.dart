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
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Center(
        child: AnimatedFlipCounter(
          value: count,
          textStyle: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
    );
  }
}
