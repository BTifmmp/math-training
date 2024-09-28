import 'package:flutter/material.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/widgets/select_mode_box.dart';
import 'package:math_training/widgets/titled_row.dart';

class SpeedTrainingsListView extends StatefulWidget {
  const SpeedTrainingsListView({super.key});

  @override
  State<SpeedTrainingsListView> createState() => _SpeedTrainingsListViewState();
}

class _SpeedTrainingsListViewState extends State<SpeedTrainingsListView>
    with AutomaticKeepAliveClientMixin<SpeedTrainingsListView> {
  final row1 = ScrollController();
  final row2 = ScrollController();
  final row3 = ScrollController();

  @override
  void dispose() {
    row1.dispose();
    row2.dispose();
    row3.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              'Speed Training',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TitledRow(
            controller: row1,
            title: 'Mixed',
            children: [
              TrainingSelectModeBox(
                  image: 'assets/images/mixed.png',
                  title: 'Easy',
                  description: 'Set your best time!',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SpeedTrainingPage()));
                  },
                  difficulty: 0),
              TrainingSelectModeBox(
                  image: 'assets/images/mixed.png',
                  title: 'Medium',
                  description: 'Set your best time!',
                  onTap: () {},
                  difficulty: 1),
              TrainingSelectModeBox(
                  image: 'assets/images/mixed.png',
                  title: 'Hard',
                  description: 'Set your best time!',
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
                  description: 'Set your best time!',
                  onTap: () {},
                  difficulty: 0),
              TrainingSelectModeBox(
                  image: 'assets/images/plusminus.png',
                  title: 'Medium',
                  description: 'Set your best time!',
                  onTap: () {},
                  difficulty: 1),
              TrainingSelectModeBox(
                  image: 'assets/images/plusminus.png',
                  title: 'Hard',
                  description: 'Set your best time!',
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
                  description: 'Set your best time!',
                  onTap: () {},
                  difficulty: 0),
              TrainingSelectModeBox(
                  image: 'assets/images/multdiv.png',
                  title: 'Medium',
                  description: 'Set your best time!',
                  onTap: () {},
                  difficulty: 1),
              TrainingSelectModeBox(
                  image: 'assets/images/multdiv.png',
                  title: 'Hard',
                  description: 'Set your best time!',
                  onTap: () {},
                  difficulty: 2),
            ],
          )
        ],
      ),
    );
  }
}
