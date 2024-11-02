import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/math_crossword/presentation/math_crossword_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/select_mode_box.dart';
import 'package:math_training/features/trainings/presentation/widgets/training_type_panel.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_app_bar.dart';
import 'package:math_training/utils/duration_formatter.dart';
import 'package:math_training/widgets/info_modal.dart';

class GamesListPage extends StatelessWidget {
  const GamesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statsCubit = StatisitcsCubit(
        statisticRepository: context.read<StatisticRepository>());
    statsCubit.refreshOnSpeedChnage(() {
      statsCubit.getAllBestSpeedTrainingTimes();
    });
    return BlocProvider.value(
      value: statsCubit,
      child: const GamesListView(),
    );
  }
}

class GamesListView extends StatefulWidget {
  const GamesListView({super.key});

  @override
  State<GamesListView> createState() => _GamesListViewState();
}

class _GamesListViewState extends State<GamesListView>
    with AutomaticKeepAliveClientMixin<GamesListView> {
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
                            'Games',
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
                      title: 'Crossword',
                      imagePath: 'assets/images/multdiv.png',
                      modeBoxes: [
                        TrainingSelectModeBox(
                          title: 'Small',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .multiplicationDivisionEasy)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionEasy] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const MathCrosswordPage(
                                    size: GameSize.standard)));
                          },
                        ),
                        TrainingSelectModeBox(
                          title: 'Big',
                          description: areBestTimeFetched &&
                                  state.bestTimes.containsKey(SpeedTrainingType
                                      .multiplicationDivisionEasy)
                              ? "Best time: ${formatDuration(Duration(milliseconds: state.bestTimes[SpeedTrainingType.multiplicationDivisionEasy] ?? 0))}"
                              : 'Set best time!',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const MathCrosswordPage(
                                    size: GameSize.big)));
                          },
                        ),
                      ]),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            TrainingsAppBar(title: 'Games', visible: _visible),
          ],
        );
      },
    );
  }
}
