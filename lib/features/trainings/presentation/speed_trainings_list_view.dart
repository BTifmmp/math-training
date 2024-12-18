import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_list_template.dart';
import 'package:math_training/utils/duration_formatter.dart';

class SpeedTrainingsListPage extends StatelessWidget {
  const SpeedTrainingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statsCubit = StatisitcsCubit(
        statisticRepository: context.read<StatisticRepository>());
    statsCubit.refreshOnSpeedChange(() {
      statsCubit.getAllBestSpeedTrainingTimes();
    });
    statsCubit.getAllBestSpeedTrainingTimes();
    return BlocProvider.value(
      value: statsCubit,
      child: const SpeedTrainingsListView(),
    );
  }
}

class SpeedTrainingsListView extends StatelessWidget {
  const SpeedTrainingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisitcsCubit, StatisticsState>(
        builder: (context, state) {
      final bool areBestTimeFetched = state is StatisticsSuccessAllBestTimes;
      return TrainingsListTemplate(title: "Speed", trainingPanels: [
        TrainingTypePanel(
            color: TrainingImageConfig.mixedSpeed.color,
            title: 'Mixed',
            imagePath: TrainingImageConfig.mixedSpeed.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(SpeedTrainingType.mixedEasy)
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
                        state.bestTimes
                            .containsKey(SpeedTrainingType.mixedMedium)
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
                        state.bestTimes.containsKey(SpeedTrainingType.mixedHard)
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
        TrainingTypePanel(
            color: TrainingImageConfig.addSubstractSpeed.color,
            title: 'Addition & Substraction',
            imagePath: TrainingImageConfig.addSubstractSpeed.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(
                            SpeedTrainingType.additionSubstractionEasy)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.additionSubstractionEasy] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                            trainingConfig: TrainingConfig.addSubstractEasy,
                            type: SpeedTrainingType.additionSubstractionEasy,
                          )));
                },
              ),
              TrainingSelectModeBox(
                title: 'Medium',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(
                            SpeedTrainingType.additionSubstractionMedium)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.additionSubstractionMedium] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                        trainingConfig: TrainingConfig.addSubstractMedium,
                        type: SpeedTrainingType.additionSubstractionMedium,
                      ),
                    ),
                  );
                },
              ),
              TrainingSelectModeBox(
                title: 'Hard',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(
                            SpeedTrainingType.additionSubstractionHard)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.additionSubstractionHard] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                        trainingConfig: TrainingConfig.addSubstractHard,
                        type: SpeedTrainingType.additionSubstractionHard,
                      ),
                    ),
                  );
                },
              ),
            ]),
        TrainingTypePanel(
            color: TrainingImageConfig.multDivSpeed.color,
            title: 'Multiplication & Division',
            imagePath: TrainingImageConfig.multDivSpeed.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(
                            SpeedTrainingType.multiplicationDivisionEasy)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionEasy] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                            trainingConfig: TrainingConfig.multDivEasy,
                            type: SpeedTrainingType.multiplicationDivisionEasy,
                          )));
                },
              ),
              TrainingSelectModeBox(
                title: 'Medium',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(
                            SpeedTrainingType.multiplicationDivisionMedium)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionMedium] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                        trainingConfig: TrainingConfig.multDivMedium,
                        type: SpeedTrainingType.multiplicationDivisionMedium,
                      ),
                    ),
                  );
                },
              ),
              TrainingSelectModeBox(
                title: 'Hard',
                description: areBestTimeFetched &&
                        state.bestTimes.containsKey(
                            SpeedTrainingType.multiplicationDivisionHard)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionHard] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                        trainingConfig: TrainingConfig.multDivHard,
                        type: SpeedTrainingType.multiplicationDivisionHard,
                      ),
                    ),
                  );
                },
              ),
            ]),
        TrainingTypePanel(
            color: TrainingImageConfig.rootPowerSpeed.color,
            title: 'Powers & Roots',
            imagePath: TrainingImageConfig.rootPowerSpeed.imgPath,
            modeBoxes: [
              TrainingSelectModeBox(
                title: 'Easy',
                description: areBestTimeFetched &&
                        state.bestTimes
                            .containsKey(SpeedTrainingType.powerRootEasy)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.powerRootEasy] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                            trainingConfig: TrainingConfig.rootPowerEasy,
                            type: SpeedTrainingType.powerRootEasy,
                          )));
                },
              ),
              TrainingSelectModeBox(
                title: 'Medium',
                description: areBestTimeFetched &&
                        state.bestTimes
                            .containsKey(SpeedTrainingType.powerRootMedium)
                    ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.powerRootMedium] ?? 0))}"
                    : 'Set best time!',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SpeedTrainingPage(
                        trainingConfig: TrainingConfig.rootPowerMedium,
                        type: SpeedTrainingType.powerRootMedium,
                      ),
                    ),
                  );
                },
              ),
              TrainingSelectModeBox(
                title: 'Hard',
                description: areBestTimeFetched &&
                        state.bestTimes
                            .containsKey(SpeedTrainingType.powerRootHard)
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
      ]);
    });
  }
}
