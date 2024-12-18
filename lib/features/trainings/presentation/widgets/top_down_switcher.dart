import 'package:flutter/material.dart';

class TopDownSwitcher extends StatelessWidget {
  final double offsetVertical;
  final Widget child;
  final Key newChildKey;
  const TopDownSwitcher(
      {super.key,
      required this.child,
      required this.newChildKey,
      this.offsetVertical = 0.1});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOutSine,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 0),
      child: child,
      transitionBuilder: (child, animation) {
        final inAnimation = Tween<Offset>(
                begin: Offset(0, -offsetVertical), end: const Offset(0, 0))
            .animate(animation);

        final fadeAnimation = animation.drive(Tween<double>(
          begin: 0.3, // Fully transparent
          end: 1.0, // Fully visible
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: inAnimation, child: child),
        );
      },
    );
  }
}
