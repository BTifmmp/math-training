import 'package:flutter/material.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/features/trainings/presentation/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/trainings_app_bar.dart';
import 'package:math_training/widgets/info_modal.dart';

class SpeedTrainingsListView extends StatefulWidget {
  const SpeedTrainingsListView({super.key});

  @override
  State<SpeedTrainingsListView> createState() => _SpeedTrainingsListViewState();
}

class _SpeedTrainingsListViewState extends State<SpeedTrainingsListView>
    with AutomaticKeepAliveClientMixin<SpeedTrainingsListView> {
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.mixedEasy,
                            ),
                          ),
                        );
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Medium',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.mixedMedium,
                            ),
                          ),
                        );
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Hard',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.mixedHard,
                            ),
                          ),
                        );
                      },
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
                            builder: (_) => const SpeedTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.addSubstractEasy,
                                )));
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Medium',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.addSubstractMedium,
                            ),
                          ),
                        );
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Hard',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.addSubstractHard,
                            ),
                          ),
                        );
                      },
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
                            builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.multDivEasy,
                                )));
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Medium',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.multDivMedium,
                            ),
                          ),
                        );
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Hard',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.multDivHard,
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 20),
              TrainingTypePanel(
                  title: 'Powers & Roots',
                  imagePath: 'assets/images/multdiv.png',
                  modeBoxes: [
                    TrainingSelectModeBox(
                      title: 'Easy',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.rootPowerEasy,
                                )));
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Medium',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.rootPowerMedium,
                            ),
                          ),
                        );
                      },
                    ),
                    TrainingSelectModeBox(
                      title: 'Hard',
                      description: 'Set best time!',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SpeedTrainingPage(
                              trainingConfig: TrainingConfig.rootPowerHard,
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 20),
            ],
          ),
        ),
        TrainingsAppBar(title: 'Speed Training', visible: _visible),
      ],
    );
  }
}
