import 'package:flutter/material.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/trainings/presentation/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/training_type_panel.dart';
import 'package:math_training/widgets/info_modal.dart';

class SpeedTrainingsListView extends StatefulWidget {
  const SpeedTrainingsListView({super.key});

  @override
  State<SpeedTrainingsListView> createState() => _SpeedTrainingsListViewState();
}

class _SpeedTrainingsListViewState extends State<SpeedTrainingsListView>
    with AutomaticKeepAliveClientMixin<SpeedTrainingsListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(
                  child: Text(
                    'Speed Training',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                      onPressed: () {
                        showInfoModal(context);
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 32,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          TrainingTypePanel(
              title: 'Mixed',
              imagePath: 'assets/images/mixed.png',
              modeBoxes: [
                TrainingSelectModeBox(
                  title: 'Easy',
                  description: 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SpeedTrainingPage()));
                  },
                ),
                TrainingSelectModeBox(
                  title: 'Medium',
                  description: 'Set best time!',
                  onTap: () {},
                ),
                TrainingSelectModeBox(
                  title: 'Hard',
                  description: 'Set best time!',
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
                  description: 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SpeedTrainingPage()));
                  },
                ),
                TrainingSelectModeBox(
                  title: 'Medium',
                  description: 'Set best time!',
                  onTap: () {},
                ),
                TrainingSelectModeBox(
                  title: 'Hard',
                  description: 'Set best time!',
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
                  description: 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SpeedTrainingPage()));
                  },
                ),
                TrainingSelectModeBox(
                  title: 'Medium',
                  description: 'Set best time!',
                  onTap: () {},
                ),
                TrainingSelectModeBox(
                  title: 'Hard',
                  description: 'Set best time!',
                  onTap: () {},
                ),
              ]),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
