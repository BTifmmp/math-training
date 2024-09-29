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
      this.value = value;
    } else {
      this.value += value;
    }
    notifyListeners();
  }
}

class NumberInput extends StatelessWidget {
  final NumberInputController controller;
  final Color? backgroundColor;
  const NumberInput(
      {super.key, required numberInputController, this.backgroundColor})
      : controller = numberInputController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),
      child: Expanded(
        flex: 9999,
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            '45399dd99',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                    NumberInputButton(
                        text: 'C', onTap: () => controller.clear()),
                  ],
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          NumberInputButton(
                              text: '0', onTap: () => controller.add('0')),
                          NumberInputButton(
                              text: '1', onTap: () => controller.add('1')),
                          NumberInputButton(
                              text: '2', onTap: () => controller.add('2')),
                          NumberInputButton(
                              text: '3', onTap: () => controller.add('3')),
                          NumberInputButton(
                              text: '4', onTap: () => controller.add('4')),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          NumberInputButton(
                              text: '5', onTap: () => controller.add('5')),
                          NumberInputButton(
                              text: '6', onTap: () => controller.add('6')),
                          NumberInputButton(
                              text: '7', onTap: () => controller.add('7')),
                          NumberInputButton(
                              text: '8', onTap: () => controller.add('8')),
                          NumberInputButton(
                              text: '9', onTap: () => controller.add('9')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberInputButton extends StatefulWidget {
  final String text;
  final GestureTapCallback onTap;
  final Color? textColor;
  const NumberInputButton(
      {super.key, required this.text, required this.onTap, this.textColor});

  @override
  State<NumberInputButton> createState() => _NumberInputButtonState();
}

class _NumberInputButtonState extends State<NumberInputButton> {
  Color _color = Colors.transparent;
  double _fontSize = 35;
  int _duration = 150;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => {
          setState(() {
            _color = Theme.of(context).colorScheme.onSurface.withOpacity(0.1);
            _fontSize = 28;
            _duration = 0;
          })
        },
        onTapUp: (_) => {
          setState(() {
            _color = Colors.transparent;
            _fontSize = 35;
            _duration = 150;
          })
        },
        onTapCancel: () => {
          setState(() {
            _color = Colors.transparent;
            _fontSize = 35;
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
