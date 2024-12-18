import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/magic_square/presentation/magic_square_view.dart';
import 'package:math_training/features/math_crossword/presentation/math_crossword_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_list_template.dart';
import 'package:math_training/utils/duration_formatter.dart';

class GamesListPage extends StatelessWidget {
  const GamesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statsCubit = StatisitcsCubit(
        statisticRepository: context.read<StatisticRepository>());
    statsCubit.refreshOnGamesChange(() {
      statsCubit.getAllBestGamesTimes();
    });
    statsCubit.getAllBestGamesTimes();
    return BlocProvider.value(
      value: statsCubit,
      child: const GamesListView(),
    );
  }
}

class GamesListView extends StatelessWidget {
  const GamesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisitcsCubit, StatisticsState>(
      builder: (context, state) {
        final bool areBestTimeFetched =
            state is StatisticsSuccessAllBestTimesGames;
        return TrainingsListTemplate(
          title: 'Games',
          trainingPanels: [
            TrainingTypePanel(
              color: TrainingImageConfig.crossword.color,
              title: 'Crossword',
              imagePath: TrainingImageConfig.crossword.imgPath,
              modeBoxes: [
                TrainingSelectModeBox(
                  title: 'Small',
                  description: areBestTimeFetched &&
                          state.bestTimesGames
                              .containsKey(GameType.crossWordSmall)
                      ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimesGames[GameType.crossWordSmall] ?? 0))}"
                      : 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MathCrosswordPage(
                          size: GameSize.small,
                          type: GameType.crossWordSmall,
                        ),
                      ),
                    );
                  },
                ),
                TrainingSelectModeBox(
                  title: 'Big',
                  description: areBestTimeFetched &&
                          state.bestTimesGames
                              .containsKey(GameType.crossWardBig)
                      ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimesGames[GameType.crossWardBig] ?? 0))}"
                      : 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MathCrosswordPage(
                          size: GameSize.big,
                          type: GameType.crossWardBig,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            TrainingTypePanel(
              color: TrainingImageConfig.magicSqaure.color,
              title: 'Magic Sqaure',
              imagePath: TrainingImageConfig.magicSqaure.imgPath,
              modeBoxes: [
                TrainingSelectModeBox(
                  title: '3x3',
                  description: areBestTimeFetched &&
                          state.bestTimesGames
                              .containsKey(GameType.magicSquareSmall)
                      ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimesGames[GameType.magicSquareSmall] ?? 0))}"
                      : 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MagicSquarePage(
                          size: GameSize.small,
                          type: GameType.magicSquareSmall,
                        ),
                      ),
                    );
                  },
                ),
                TrainingSelectModeBox(
                  title: '4x4',
                  description: areBestTimeFetched &&
                          state.bestTimesGames
                              .containsKey(GameType.magicSquareBig)
                      ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimesGames[GameType.magicSquareBig] ?? 0))}"
                      : 'Set best time!',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MagicSquarePage(
                          size: GameSize.big,
                          type: GameType.magicSquareBig,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
