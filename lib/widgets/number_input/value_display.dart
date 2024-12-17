import 'package:flutter/material.dart';
import 'package:math_training/widgets/number_input/number_input_controller.dart';

class NumberInputValueDisplay extends StatefulWidget {
  final NumberInputController _numberInputController;

  const NumberInputValueDisplay({super.key, required numberInputController})
      : _numberInputController = numberInputController;

  @override
  State<NumberInputValueDisplay> createState() =>
      _NumberInputValueDisplayState();
}

class _NumberInputValueDisplayState extends State<NumberInputValueDisplay> {
  late final GlobalKey _textKey = GlobalKey();
  double _targetWidth = 40;

  void _updateTargetSize() {
    final RenderBox renderBox =
        _textKey.currentContext!.findRenderObject() as RenderBox;
    if (_targetWidth != renderBox.size.width) {
      setState(() {
        _targetWidth = renderBox.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListenableBuilder(
          listenable: widget._numberInputController,
          builder: (context, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateTargetSize();
            });
            return Text(
              key: _textKey,
              widget._numberInputController.value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w300,
                fontSize: 50,
                height: 1.1,
              ),
            );
          },
        ),
        AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 150),
          height: 3,
          width: _targetWidth > 40 ? _targetWidth : 40,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(9999)),
        ),
      ],
    );
  }
}
