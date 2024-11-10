import 'package:flutter/material.dart';

class NumberInputController with ChangeNotifier {
  String value = '';
  bool clearScheduled = false;

  void delayedClear(Duration delay) async {
    clearScheduled = true;
    Future.delayed(delay, () {
      if (clearScheduled) {
        value = '';
        clearScheduled = false;
        notifyListeners();
      }
    });
  }

  void clear() {
    value = '';
    notifyListeners();
  }

  void add(String value) {
    if (clearScheduled) {
      clearScheduled = false;
      this.value = _nextValue('', value);
    } else {
      this.value = _nextValue(this.value, value);
    }

    notifyListeners();
  }

  String _nextValue(String currentValue, String addedValue) {
    if (currentValue == '0' && addedValue != '.') {
      return addedValue;
    }
    if (addedValue == '.') {
      if (currentValue == '') {
        return '0.';
      } else if (currentValue.endsWith('.')) {
        return currentValue;
      }
    }

    return currentValue + addedValue;
  }
}

class NumberInput extends StatelessWidget {
  final NumberInputController controller;
  const NumberInput({super.key, required numberInputController})
      : controller = numberInputController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
      child: Container(
        color: const Color.fromARGB(255, 31, 39, 53),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                      text: '1',
                      onTap: () => controller.add('1'),
                      padding: 5.0),
                  NumberInputButton(
                      text: '2',
                      onTap: () => controller.add('2'),
                      padding: 5.0),
                  NumberInputButton(
                      text: '3',
                      onTap: () => controller.add('3'),
                      padding: 5.0),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                      text: '4',
                      onTap: () => controller.add('4'),
                      padding: 5.0),
                  NumberInputButton(
                      text: '5',
                      onTap: () => controller.add('5'),
                      padding: 5.0),
                  NumberInputButton(
                      text: '6',
                      onTap: () => controller.add('6'),
                      padding: 5.0),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                    text: '7',
                    onTap: () => controller.add('7'),
                    padding: 5.0,
                  ),
                  NumberInputButton(
                      text: '8',
                      onTap: () => controller.add('8'),
                      padding: 5.0),
                  NumberInputButton(
                      text: '9',
                      onTap: () => controller.add('9'),
                      padding: 5.0),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                    text: 'C',
                    onTap: () => controller.clear(),
                    padding: 5.0,
                  ),
                  NumberInputButton(
                      text: '0',
                      onTap: () => controller.add('0'),
                      padding: 5.0),
                  NumberInputButton(
                      text: '.',
                      onTap: () => controller.add('.'),
                      padding: 5.0),
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
  final double padding;
  final String text;
  final GestureTapCallback onTap;
  final Color? textColor;
  const NumberInputButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.textColor,
      required this.padding});

  @override
  State<NumberInputButton> createState() => _NumberInputButtonState();
}

class _NumberInputButtonState extends State<NumberInputButton> {
  double _scale = 1.0;
  Color _color = Colors.transparent;
  double _fontSize = 30;
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
            _fontSize = 25;
            _duration = 0;
          })
        },
        onTapUp: (_) => {
          setState(() {
            _color = Colors.transparent;
            _scale = 1.0;
            _fontSize = 30;
            _duration = 150;
          })
        },
        onTapCancel: () => {
          setState(() {
            _color = Colors.transparent;
            _scale = 1.0;
            _fontSize = 30;
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AnimatedContainer(
                    curve: Curves.ease,
                    duration: Duration(milliseconds: _duration),
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(12),
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
                fontSize: _fontSize,
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
