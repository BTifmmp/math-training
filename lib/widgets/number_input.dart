import 'dart:math';

import 'package:flutter/material.dart';

class NumberInputController with ChangeNotifier {
  String value = '';
  void clear() {
    value = '';
    notifyListeners();
  }

  void setValue(String value) {
    this.value = value;
    notifyListeners();
  }
}

class NumberInput extends StatelessWidget {
  final NumberInputController _controller;
  const NumberInput({super.key, required numberInputController})
      : _controller = numberInputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                      text: '1',
                      onTap: () =>
                          {_controller.setValue('${_controller.value}1')}),
                  NumberInputButton(
                      text: '2',
                      onTap: () =>
                          {_controller.setValue('${_controller.value}2')}),
                  NumberInputButton(
                      text: '3',
                      onTap: () =>
                          {_controller.setValue('${_controller.value}3')}),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                      text: '4',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}4')}
                          }),
                  NumberInputButton(
                      text: '5',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}5')}
                          }),
                  NumberInputButton(
                      text: '6',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}6')}
                          }),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                      text: '7',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}7')}
                          }),
                  NumberInputButton(
                      text: '8',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}8')}
                          }),
                  NumberInputButton(
                      text: '9',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}9')}
                          }),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                      text: 'C', onTap: () => {_controller.clear()}),
                  NumberInputButton(
                      text: '0',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}0')}
                          }),
                  NumberInputButton(
                      text: '.',
                      onTap: () => {
                            {_controller.setValue('${_controller.value}.')}
                          }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberInputButton extends StatefulWidget {
  final String text;
  final GestureTapCallback onTap;
  final Color textColor;
  const NumberInputButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.textColor = const Color.fromARGB(255, 66, 66, 66)});

  @override
  State<NumberInputButton> createState() => _NumberInputButtonState();
}

class _NumberInputButtonState extends State<NumberInputButton> {
  Color _color = const Color.fromARGB(255, 255, 255, 255);
  double _fontSize = 42;
  int _duration = 150;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => {
          setState(() {
            _color = const Color.fromARGB(255, 238, 238, 238);
            _fontSize = 34;
            _duration = 0;
          })
        },
        onTapUp: (_) => {
          setState(() {
            _color = const Color.fromARGB(255, 255, 255, 255);
            _fontSize = 42;
            _duration = 150;
          })
        },
        onTapCancel: () => {
          setState(() {
            _color = const Color.fromARGB(255, 255, 255, 255);
            _fontSize = 42;
            _duration = 150;
          })
        },
        child: Stack(children: [
          Center(
            child: AspectRatio(
                aspectRatio: 1,
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                      color: _color, borderRadius: BorderRadius.circular(9999)),
                  curve: Curves.ease,
                  duration: Duration(milliseconds: _duration),
                )),
          ),
          Center(
            child: AnimatedDefaultTextStyle(
              curve: Curves.ease,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.w300,
                color: widget.textColor,
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

class NumberInputValueDisplayer extends StatefulWidget {
  final NumberInputController _numberInputController;

  const NumberInputValueDisplayer({super.key, required numberInputController})
      : _numberInputController = numberInputController;

  @override
  State<NumberInputValueDisplayer> createState() =>
      _NumberInputValueDisplayerState();
}

class _NumberInputValueDisplayerState extends State<NumberInputValueDisplayer> {
  late final GlobalKey _textKey = GlobalKey();
  double _targetWidth = 40;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWidgetSize();
    });
    super.initState();
  }

  double _getWidgetSize() {
    final RenderBox renderBox =
        _textKey.currentContext!.findRenderObject() as RenderBox;
    if (_targetWidth != renderBox.size.width) {
      setState(() {
        _targetWidth = renderBox.size.width;
      });
    }

    return _targetWidth;
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
              _getWidgetSize();
            });
            return Text(
              key: _textKey,
              widget._numberInputController.value,
              style: const TextStyle(
                color: const Color.fromARGB(255, 66, 66, 66),
                fontWeight: FontWeight.w300,
                fontSize: 60,
                height: 1.1,
              ),
            );
          },
        ),
        AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 200),
          height: 3,
          width: _targetWidth > 40 ? _targetWidth : 40,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 66, 66, 66),
              borderRadius: BorderRadius.circular(9999)),
        ),
      ],
    );
  }
}
