import 'package:flutter/material.dart';
import 'package:math_training/widgets/number_input.dart';

class SpeedTrainingView extends StatefulWidget {
  const SpeedTrainingView({super.key});

  @override
  State<SpeedTrainingView> createState() => _SpeedTrainingViewState();
}

class _SpeedTrainingViewState extends State<SpeedTrainingView> {
  final _numberInputController = NumberInputController();

  @override
  void dispose() {
    _numberInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          NumberInputValueDisplayer(
              numberInputController: _numberInputController),
          const Spacer(),
          NumberInput(
            numberInputController: _numberInputController,
          ),
        ],
      ),
    );
  }
}
