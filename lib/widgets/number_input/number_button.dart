import 'package:flutter/material.dart';

class NumberInputButton extends StatefulWidget {
  final double padding;
  final String text;
  final double fontSize;
  final GestureTapCallback onTap;
  final Color? textColor;
  const NumberInputButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.textColor,
      required this.padding,
      this.fontSize = 26});

  @override
  State<NumberInputButton> createState() => _NumberInputButtonState();
}

class _NumberInputButtonState extends State<NumberInputButton> {
  double _scale = 1.0;
  Color _color = Colors.transparent;
  double? _fontSize;
  int _duration = 150;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => {
          setState(() {
            _color = Theme.of(context).colorScheme.onSurface.withOpacity(0.05);
            _scale = 0.95;
            _fontSize = widget.fontSize * 0.9;
            _duration = 0;
          })
        },
        onTapUp: (_) => {
          setState(() {
            _color = Colors.transparent;
            _scale = 1.0;
            _fontSize = widget.fontSize;
            _duration = 150;
          })
        },
        onTapCancel: () => {
          setState(() {
            _color = Colors.transparent;
            _scale = 1.0;
            _fontSize = widget.fontSize;
            _duration = 150;
          })
        },
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.all(widget.padding),
            child: Center(
              child: AnimatedScale(
                scale: _scale,
                curve: Curves.ease,
                duration: Duration(milliseconds: _duration),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AnimatedContainer(
                    curve: Curves.ease,
                    duration: Duration(milliseconds: _duration),
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedDefaultTextStyle(
              curve: Curves.ease,
              style: TextStyle(
                fontSize: _fontSize ?? widget.fontSize,
                fontWeight: FontWeight.w300,
                color:
                    widget.textColor ?? Theme.of(context).colorScheme.onSurface,
              ),
              duration: Duration(milliseconds: _duration),
              child: Text(widget.text),
            ),
          ),
        ]),
      ),
    );
  }
}
