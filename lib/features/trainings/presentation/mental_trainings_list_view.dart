import 'package:flutter/material.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_view.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_list_template.dart';

class MentalTrainingsListView extends StatelessWidget {
  const MentalTrainingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return TrainingsListTemplate(
      title: 'Mental',
      trainingPanels: [
        TrainingTypePanel(
            color: TrainingImageConfig.mixedMental.color,
            title: 'Mixed',
            imagePath: TrainingImageConfig.mixedMental.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: 'Correct answers: 0',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.mixedMentalEasy,
                          )));
                },
              ),
              TrainingSelectModeBox(
                title: 'Medium',
                description: 'Correct answers: 0',
                onTap: () {},
              ),
              TrainingSelectModeBox(
                title: 'Hard',
                description: 'Correct answers: 0',
                onTap: () {},
              ),
            ]),
        TrainingTypePanel(
            color: TrainingImageConfig.addSubstractMental.color,
            title: 'Addition & Substraction',
            imagePath: TrainingImageConfig.addSubstractMental.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: 'Correct answers: 0',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.addSubstractEasy,
                          )));
                },
              ),
              TrainingSelectModeBox(
                title: 'Medium',
                description: 'Correct answers: 0',
                onTap: () {},
              ),
              TrainingSelectModeBox(
                title: 'Hard',
                description: 'Correct answers: 0',
                onTap: () {},
              ),
            ]),
        TrainingTypePanel(
            color: TrainingImageConfig.multDivMental.color,
            title: 'Multiplication & Division',
            imagePath: TrainingImageConfig.multDivMental.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: 'Correct answers: 0',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.addSubstractEasy,
                          )));
                },
              ),
              TrainingSelectModeBox(
                title: 'Medium',
                description: 'Correct answers: 0',
                onTap: () {},
              ),
              TrainingSelectModeBox(
                title: 'Hard',
                description: 'Correct answers: 0',
                onTap: () {},
              ),
            ]),
      ],
    );
  }
}
