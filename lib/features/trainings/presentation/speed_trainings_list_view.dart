import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_app_bar.dart';
import 'package:math_training/utils/duration_formatter.dart';
import 'package:math_training/widgets/info_modal.dart';

class SpeedTrainingsListPage extends StatelessWidget {
  const SpeedTrainingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statsCubit = StatisitcsCubit(
        statisticRepository: context.read<StatisticRepository>());
    statsCubit.refreshOnSpeedChange(() {
      statsCubit.getAllBestSpeedTrainingTimes();
    });
    return BlocProvider.value(
      value: statsCubit,
      child: const SpeedTrainingsListView(),
    );
  }
}

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
    context.read<StatisitcsCubit>().getAllBestSpeedTrainingTimes();
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
    return BlocBuilder<StatisitcsCubit, StatisticsState>(
      builder: (context, state) {
        final bool areBestTimeFetched = state is StatisticsSuccessAllBestTimes;
        return Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                            'Speed',
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
                          description: areBestTimeFetched &&
                                  state.bestTimes
                                      .containsKey(SpeedTrainingType.mixedEasy)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.mixedEasy] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.mixedEasy,
                                  type: SpeedTrainingType.mixedEasy,
                                ),
                              ),
                            );
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Medium',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(
                                      SpeedTrainingType.mixedMedium)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.mixedMedium] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.mixedMedium,
                                  type: SpeedTrainingType.mixedMedium,
                                ),
                              ),
                            );
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Hard',
                          description: areBestTimeFetched &&
                                  state.bestTimes
                                      .containsKey(SpeedTrainingType.mixedHard)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.mixedHard] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.mixedHard,
                                  type: SpeedTrainingType.mixedHard,
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
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .additionSubstractionEasy)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.additionSubstractionEasy] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                      trainingConfig:
                                          TrainingConfig.addSubstractEasy,
                                      type: SpeedTrainingType
                                          .additionSubstractionEasy,
                                    )));
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Medium',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .additionSubstractionMedium)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.additionSubstractionMedium] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.addSubstractMedium,
                                  type: SpeedTrainingType
                                      .additionSubstractionMedium,
                                ),
                              ),
                            );
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Hard',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .additionSubstractionHard)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.additionSubstractionHard] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.addSubstractHard,
                                  type: SpeedTrainingType
                                      .additionSubstractionHard,
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
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .multiplicationDivisionEasy)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionEasy] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                      trainingConfig:
                                          TrainingConfig.multDivEasy,
                                      type: SpeedTrainingType
                                          .multiplicationDivisionEasy,
                                    )));
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Medium',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .multiplicationDivisionMedium)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionMedium] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.multDivMedium,
                                  type: SpeedTrainingType
                                      .multiplicationDivisionMedium,
                                ),
                              ),
                            );
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Hard',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .multiplicationDivisionHard)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionHard] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.multDivHard,
                                  type: SpeedTrainingType
                                      .multiplicationDivisionHard,
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
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(
                                      SpeedTrainingType.powerRootEasy)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.powerRootEasy] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                      trainingConfig:
                                          TrainingConfig.rootPowerEasy,
                                      type: SpeedTrainingType.powerRootEasy,
                                    )));
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Medium',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(
                                      SpeedTrainingType.powerRootMedium)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.powerRootMedium] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig:
                                      TrainingConfig.rootPowerMedium,
                                  type: SpeedTrainingType.powerRootMedium,
                                ),
                              ),
                            );
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Hard',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(
                                      SpeedTrainingType.powerRootHard)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.powerRootHard] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SpeedTrainingPage(
                                  trainingConfig: TrainingConfig.rootPowerHard,
                                  type: SpeedTrainingType.powerRootHard,
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
            TrainingsAppBar(title: 'Speed', visible: _visible),
          ],
        );
      },
    );
  }
}
