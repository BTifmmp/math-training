import 'package:flutter/material.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_view.dart';
import 'package:math_training/widgets/select_mode_box.dart';
import 'package:math_training/widgets/titled_row.dart';

class MentalTrainingsListView extends StatefulWidget {
  const MentalTrainingsListView({super.key});

  @override
  State<MentalTrainingsListView> createState() =>
      _MentalTrainingsListViewState();
}

class _MentalTrainingsListViewState extends State<MentalTrainingsListView>
    with AutomaticKeepAliveClientMixin<MentalTrainingsListView> {
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
                        builder: (_) => const MentalTrainingPage()));
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
