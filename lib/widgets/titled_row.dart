import 'package:flutter/material.dart';

class TitledRow extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const TitledRow({
    super.key,
    required this.title,
    required this.children,
  });

  List<Widget> spaceChildren() {
    List<Widget> result = [];

    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i != children.length - 1) {
        result.add(const SizedBox(width: 10));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: spaceChildren(),
            ),
          ),
        ),
      ],
    );
  }
}
