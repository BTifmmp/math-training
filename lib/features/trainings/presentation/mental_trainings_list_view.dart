import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_list_template.dart';

class MentalTrainingsListPage extends StatelessWidget {
  const MentalTrainingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statsCubit = StatisitcsCubit(
        statisticRepository: context.read<StatisticRepository>());
    statsCubit.refreshOnMentalChange(() {
      statsCubit.getAllMentalTrainingStats();
    });
    statsCubit.getAllMentalTrainingStats();
    return BlocProvider.value(
      value: statsCubit,
      child: const MentalTrainingsListView(),
    );
  }
}

class MentalTrainingsListView extends StatelessWidget {
  const MentalTrainingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisitcsCubit, StatisticsState>(
      builder: (context, state) {
        final bool areStatsFetched =
            state is StatisticsSuccessAllMentalTrainingStats;

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
                    description: areStatsFetched &&
                            state.allMentalStats
                                .containsKey(MentalTrainingType.mixedEasy)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.mixedEasy]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.mixedMentalEasy,
                            type: MentalTrainingType.mixedEasy,
                          ),
                        ),
                      );
                    },
                  ),
                  TrainingSelectModeBox(
                    title: 'Medium',
                    description: areStatsFetched &&
                            state.allMentalStats
                                .containsKey(MentalTrainingType.mixedMedium)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.mixedMedium]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.mixedMentalMedium,
                            type: MentalTrainingType.mixedMedium,
                          ),
                        ),
                      );
                    },
                  ),
                  TrainingSelectModeBox(
                    title: 'Hard',
                    description: areStatsFetched &&
                            state.allMentalStats
                                .containsKey(MentalTrainingType.mixedHard)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.mixedHard]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.mixedMentalHard,
                            type: MentalTrainingType.mixedHard,
                          ),
                        ),
                      );
                    },
                  ),
                ]),
            TrainingTypePanel(
                color: TrainingImageConfig.addSubstractMental.color,
                title: 'Addition & Substraction',
                imagePath: TrainingImageConfig.addSubstractMental.imgPath,
                modeBoxes: [
                  TrainingSelectModeBox(
                    title: 'Easy',
                    description: areStatsFetched &&
                            state.allMentalStats.containsKey(
                              MentalTrainingType.additionSubstractionEasy,
                            )
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.additionSubstractionEasy]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.addSubstractEasy,
                            type: MentalTrainingType.additionSubstractionEasy,
                          ),
                        ),
                      );
                    },
                  ),
                  TrainingSelectModeBox(
                    title: 'Medium',
                    description: areStatsFetched &&
                            state.allMentalStats.containsKey(
                                MentalTrainingType.additionSubstractionMedium)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.additionSubstractionMedium]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.addSubstractMedium,
                            type: MentalTrainingType.additionSubstractionMedium,
                          ),
                        ),
                      );
                    },
                  ),
                  TrainingSelectModeBox(
                    title: 'Hard',
                    description: areStatsFetched &&
                            state.allMentalStats.containsKey(
                                MentalTrainingType.additionSubstractionHard)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.additionSubstractionHard]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.addSubstractHard,
                            type: MentalTrainingType.additionSubstractionHard,
                          ),
                        ),
                      );
                    },
                  ),
                ]),
            TrainingTypePanel(
                color: TrainingImageConfig.multDivMental.color,
                title: 'Multiplication & Division',
                imagePath: TrainingImageConfig.multDivMental.imgPath,
                modeBoxes: [
                  TrainingSelectModeBox(
                    title: 'Easy',
                    description: areStatsFetched &&
                            state.allMentalStats.containsKey(
                                MentalTrainingType.multiplicationDivisionEasy)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.multiplicationDivisionEasy]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.multDivEasy,
                            type: MentalTrainingType.multiplicationDivisionEasy,
                          ),
                        ),
                      );
                    },
                  ),
                  TrainingSelectModeBox(
                    title: 'Medium',
                    description: areStatsFetched &&
                            state.allMentalStats.containsKey(
                                MentalTrainingType.multiplicationDivisionMedium)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.multiplicationDivisionMedium]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.multDivMedium,
                            type:
                                MentalTrainingType.multiplicationDivisionMedium,
                          ),
                        ),
                      );
                    },
                  ),
                  TrainingSelectModeBox(
                    title: 'Hard',
                    description: areStatsFetched &&
                            state.allMentalStats.containsKey(
                                MentalTrainingType.multiplicationDivisionHard)
                        ? 'Correct answers: ${state.allMentalStats[MentalTrainingType.multiplicationDivisionHard]!.numberOfCorrectAnswers}'
                        : 'Correct answers: 0',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MentalTrainingPage(
                            trainingConfig: TrainingConfig.multDivHard,
                            type: MentalTrainingType.multiplicationDivisionHard,
                          ),
                        ),
                      );
                    },
                  ),
                ]),
          ],
        );
      },
    );
  }
}
