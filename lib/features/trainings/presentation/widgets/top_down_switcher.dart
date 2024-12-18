import 'package:flutter/material.dart';

class TopDownSwitcher extends StatelessWidget {
  final Widget child;
  final Key newChildKey;
  const TopDownSwitcher(
      {super.key, required this.child, required this.newChildKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeInOut,
      switchInCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 150),
      child: child,
      transitionBuilder: (child, animation) {
        final inAnimation = Tween<Offset>(
                begin: const Offset(0, -0.05), end: const Offset(0, 0))
            .animate(animation);

        final outAnimation =
            Tween<Offset>(begin: const Offset(0, 0.05), end: const Offset(0, 0))
                .animate(animation);

        final fadeAnimation = animation.drive(Tween<double>(
          begin: 0.0, // Fully transparent
          end: 1.0, // Fully visible
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
              position: child.key == newChildKey ? inAnimation : outAnimation,
              child: child),
        );
      },
    );
  }
}
