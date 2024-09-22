import 'package:flutter/material.dart';

class SelectModeBox extends StatelessWidget {
  final Color color;
  final Widget title;
  final Widget description;
  final Widget stats;
  final GestureTapCallback onTap;

  const SelectModeBox(
      {super.key,
      required this.color,
      required this.title,
      required this.description,
      required this.stats,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: color,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 280,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  description,
                  stats,
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Text("Play"),
                ],
              ),
            ),
          ),
        ));
  }
}
