import 'package:flutter/material.dart';
import 'package:math_training/widgets/number_input/number_button.dart';
import 'package:math_training/widgets/number_input/number_input_controller.dart';

class NumberInput extends StatelessWidget {
  final NumberInputController controller;
  const NumberInput({super.key, required numberInputController})
      : controller = numberInputController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.38),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                    text: '1',
                    onTap: () => controller.add('1'),
                    padding: 5.0,
                  ),
                  NumberInputButton(
                    text: '2',
                    onTap: () => controller.add('2'),
                    padding: 5.0,
                  ),
                  NumberInputButton(
                    text: '3',
                    onTap: () => controller.add('3'),
                    padding: 5.0,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  NumberInputButton(
                    text: '4',
                    onTap: () => controller.add('4'),
                    padding: 5.0,
                  ),
                  NumberInputButton(
                    text: '5',
                    onTap: () => controller.add('5'),
                    padding: 5.0,
                  ),
                  NumberInputButton(
                    text: '6',
                    onTap: () => controller.add('6'),
                    padding: 5.0,
                  ),
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
                    padding: 5.0,
                  ),
                  NumberInputButton(
                    text: '9',
                    onTap: () => controller.add('9'),
                    padding: 5.0,
                  ),
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
                    padding: 5.0,
                  ),
                  NumberInputButton(
                    text: '.',
                    onTap: () => controller.add('.'),
                    padding: 5.0,
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
