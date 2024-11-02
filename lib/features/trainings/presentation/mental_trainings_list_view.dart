import 'package:flutter/material.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_view.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_app_bar.dart';
import 'package:math_training/widgets/info_modal.dart';

class MentalTrainingsListView extends StatefulWidget {
  const MentalTrainingsListView({super.key});

  @override
  State<MentalTrainingsListView> createState() =>
      _MentalTrainingsListViewState();
}

class _MentalTrainingsListViewState extends State<MentalTrainingsListView>
    with AutomaticKeepAliveClientMixin<MentalTrainingsListView> {
  final _scrollController = ScrollController();
  bool _visible = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      _visible = _scrollController.offset > 30;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
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
                        'Mental Training',
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
                      description: 'Correct answers: 0',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const MentalTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.mixedMentalEasy,
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
                            builder: (_) => const MentalTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.addSubstractEasy,
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
                            builder: (_) => const MentalTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.addSubstractEasy,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
        TrainingsAppBar(title: 'Mental Training', visible: _visible),
      ],
    );
  }
}
