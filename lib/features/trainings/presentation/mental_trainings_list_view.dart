import 'package:flutter/material.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/widgets/select_mode_box.dart';
import 'package:math_training/widgets/titled_row.dart';

class MentalTrainingsListView extends StatelessWidget {
  const MentalTrainingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              'Mental Training',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TitledRow(
            title: 'Mixed',
            children: [
              TrainingSelectModeBox(
                  image: 'assets/images/mixed.png',
                  title: 'Easy',
                  description: 'Correct answers: 0',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SpeedTrainingPage()));
                  },
                  difficulty: 0),
              TrainingSelectModeBox(
                  image: 'assets/images/mixed.png',
                  title: 'Medium',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 1),
              TrainingSelectModeBox(
                  image: 'assets/images/mixed.png',
                  title: 'Hard',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 2),
            ],
          ),
          const SizedBox(height: 20),
          TitledRow(
            title: 'Addition & Substraction',
            children: [
              TrainingSelectModeBox(
                  image: 'assets/images/plusminus.png',
                  title: 'Easy',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 0),
              TrainingSelectModeBox(
                  image: 'assets/images/plusminus.png',
                  title: 'Medium',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 1),
              TrainingSelectModeBox(
                  image: 'assets/images/plusminus.png',
                  title: 'Hard',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 2),
            ],
          ),
          const SizedBox(height: 20),
          TitledRow(
            title: 'Mulitplication & Division',
            children: [
              TrainingSelectModeBox(
                  image: 'assets/images/multdiv.png',
                  title: 'Easy',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 0),
              TrainingSelectModeBox(
                  image: 'assets/images/multdiv.png',
                  title: 'Medium',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 1),
              TrainingSelectModeBox(
                  image: 'assets/images/multdiv.png',
                  title: 'Hard',
                  description: 'Correct answers: 0',
                  onTap: () {},
                  difficulty: 2),
            ],
          )
        ],
      ),
    );
  }
}
