import 'package:flutter/material.dart';

class TextContainerFilled extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final BoxDecoration decoration;
  final EdgeInsets padding;

  const TextContainerFilled({
    super.key,
    this.text = '',
    this.textStyle = const TextStyle(fontSize: 18),
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(9999)),
      color: Colors.black,
    ),
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Text(text, style: textStyle),
    );
  }
}

class TextContainerOutlined extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final BoxDecoration decoration;
  final EdgeInsets padding;

  const TextContainerOutlined({
    super.key,
    this.text = '',
    this.textStyle = const TextStyle(fontSize: 18),
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(9999)),
      border:
          Border.fromBorderSide(BorderSide(color: Colors.black, width: 1.0)),
    ),
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Text(text, style: textStyle),
    );
  }
}
