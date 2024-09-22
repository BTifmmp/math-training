import 'package:flutter/material.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_pre_view.dart';
import 'package:math_training/widgets/select_mode_box.dart';
import 'package:math_training/widgets/titled_row.dart';

class SpeedTrainingsListView extends StatelessWidget {
  const SpeedTrainingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        TitledRow(
          title: 'Addition',
          children: [
            SelectModeBox(
              color: Colors.cyan,
              title: const Text('Addition'),
              description: const Text(
                  'Some descritop about whats is insthat is way to logn t fitt in thereide'),
              stats: const Text('Stats: 00:000'),
              onTap: () => {},
            ),
            SelectModeBox(
              color: Colors.cyan,
              title: const Text('Addition'),
              description: const Text('Some descritop about whats is inside'),
              stats: const Text('Stats: 00:000'),
              onTap: () => {},
            ),
            SelectModeBox(
              color: Colors.cyan,
              title: const Text('Addition'),
              description: const Text('Some descritop about whats is inside'),
              stats: const Text('Stats: 00:000'),
              onTap: () => {},
            )
          ],
        ),
        TitledRow(
          title: 'Addition',
          children: [
            SelectModeBox(
              color: Colors.cyan,
              title: const Text('Addition'),
              description: const Text(
                  'Some descritop about whats is insthat is way to logn t fitt in thereide'),
              stats: const Text('Stats: 00:000'),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpeedTrainingPreView()))
              },
            ),
            SelectModeBox(
              color: Colors.cyan,
              title: const Text('Addition'),
              description: const Text('Some descritop about whats is inside'),
              stats: const Text('Stats: 00:000'),
              onTap: () => {},
            ),
            SelectModeBox(
              color: Colors.cyan,
              title: const Text('Addition'),
              description: const Text('Some descritop about whats is inside'),
              stats: const Text('Stats: 00:000'),
              onTap: () => {},
            )
          ],
        ),
      ],
    );
  }
}
