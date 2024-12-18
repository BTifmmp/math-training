import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/math_crossword/presentation/math_crossword_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/utils/duration_formatter.dart';
import 'package:math_training/widgets/training/training_summary_template.dart';

class MathCrosswordSummaryPage extends StatelessWidget {
  final GameSize size;
  final Duration time;
  final GameType type;

  const MathCrosswordSummaryPage(
      {super.key, required this.size, required this.time, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisitcsCubit>(
      create: (_) => StatisitcsCubit(
          statisticRepository: context.read<StatisticRepository>()),
      child: MathCrosswordSummaryView(size: size, time: time, type: type),
    );
  }
}

class MathCrosswordSummaryView extends StatelessWidget {
  final GameSize size;
  final Duration time;
  final GameType type;

  const MathCrosswordSummaryView(
      {super.key, required this.size, required this.time, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisitcsCubit, StatisticsState>(
        builder: (context, state) {
      String bestTime = 'Not Found';
      if (state is StatisticsInitial) {
        context.read<StatisitcsCubit>().getBestGameTime(type);
        return const Scaffold();
      } else if (state is StatisticsSuccessBestTimeGame &&
          state.bestTimeGame != null) {
        bestTime = formatDuration(Duration(milliseconds: state.bestTimeGame!));
      }

      return SummaryTemplate(
        imageConfig: TrainingImageConfig.fromGameType(type),
        title: 'Math Crossword',
        additionalInfo: [
          'Size: ${(size == GameSize.small ? "Small" : "Big")}',
          'Best time: $bestTime'
        ],
        trainingResultInfo: [
          const Text('Your time',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 22,
                fontWeight: FontWeight.w300,
              )),
          Text(formatDuration(time),
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 35,
                fontWeight: FontWeight.w400,
              )),
        ],
        onPlayAgain: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MathCrosswordPage(
                size: size,
                type: type,
              ),
            ),
          );
        },
      );
    });
  }
}
