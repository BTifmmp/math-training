import 'package:flutter/material.dart';
import 'package:math_training/widgets/number_input.dart';

class NumberInputSmall extends StatelessWidget {
  final NumberInputController controller;
  final Color? backgroundColor;
  const NumberInputSmall(
      {super.key, required numberInputController, this.backgroundColor})
      : controller = numberInputController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          children: [
            NumberInputButton(text: 'C', onTap: () => controller.clear()),
            Column(
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
          ],
        ),
      ),
    );
  }
}
