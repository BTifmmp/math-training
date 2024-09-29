import 'package:flutter/material.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_view.dart';
import 'package:math_training/widgets/select_mode_box.dart';
import 'package:math_training/widgets/training_type_panel.dart';

class MentalTrainingsListView extends StatefulWidget {
  const MentalTrainingsListView({super.key});

  @override
  State<MentalTrainingsListView> createState() =>
      _MentalTrainingsListViewState();
}

class _MentalTrainingsListViewState extends State<MentalTrainingsListView>
    with AutomaticKeepAliveClientMixin<MentalTrainingsListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
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
          TrainingTypePanel(
              title: 'Mixed',
              imagePath: 'assets/images/mixed.png',
              modeBoxes: [
                TrainingSelectModeBox(
                  title: 'Easy',
                  description: 'Correct answers: 0',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const MentalTrainingPage()));
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
          const SizedBox(height: 20),
          TrainingTypePanel(
              title: 'Addition & Substraction',
              imagePath: 'assets/images/plusminus.png',
              modeBoxes: [
                TrainingSelectModeBox(
                  title: 'Easy',
                  description: 'Correct answers: 0',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const MentalTrainingPage()));
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
          const SizedBox(height: 20),
          TrainingTypePanel(
              title: 'Multiplication & Division',
              imagePath: 'assets/images/multdiv.png',
              modeBoxes: [
                TrainingSelectModeBox(
                  title: 'Easy',
                  description: 'Correct answers: 0',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const MentalTrainingPage()));
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
