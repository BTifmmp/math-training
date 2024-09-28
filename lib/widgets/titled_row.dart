import 'package:flutter/material.dart';

class TitledRow extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ScrollController? controller;
  const TitledRow({
    super.key,
    required this.title,
    required this.children,
    this.controller,
  });

  List<Widget> spaceChildren() {
    List<Widget> result = [];

    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i != children.length - 1) {
        result.add(const SizedBox(width: 5));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        const SizedBox(height: 5),
        SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: spaceChildren(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
