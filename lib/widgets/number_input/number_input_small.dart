import 'package:flutter/material.dart';
import 'package:math_training/widgets/number_input/number_button.dart';
import 'package:math_training/widgets/number_input/number_input_controller.dart';

class NumberInputSmall extends StatelessWidget {
  final NumberInputController? controller;
  const NumberInputSmall({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.20),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            NumberInputButton(
                fontSize: 22,
                padding: 3.0,
                text: 'C',
                onTap: () => controller?.clear()),
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '0',
                            onTap: () => controller?.add('0')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '1',
                            onTap: () => controller?.add('1')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '2',
                            onTap: () => controller?.add('2')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '3',
                            onTap: () => controller?.add('3')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '4',
                            onTap: () => controller?.add('4')),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '5',
                            onTap: () => controller?.add('5')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '6',
                            onTap: () => controller?.add('6')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '7',
                            onTap: () => controller?.add('7')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '8',
                            onTap: () => controller?.add('8')),
                        NumberInputButton(
                            fontSize: 22,
                            padding: 3.0,
                            text: '9',
                            onTap: () => controller?.add('9')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
