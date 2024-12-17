import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/utils/duration_formatter.dart';
import 'package:math_training/widgets/training/training_summary_template.dart';

class SpeedTrainingSummaryPage extends StatelessWidget {
  final TrainingConfig trainingConfig;
  final Duration time;
  final SpeedTrainingType type;

  const SpeedTrainingSummaryPage(
      {super.key,
      required this.trainingConfig,
      required this.time,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisitcsCubit>(
      create: (_) => StatisitcsCubit(
          statisticRepository: context.read<StatisticRepository>()),
      child: SpeedTrainingSummaryView(
          trainingConfig: trainingConfig, time: time, type: type),
    );
  }
}

class SpeedTrainingSummaryView extends StatelessWidget {
  final TrainingConfig trainingConfig;
  final Duration time;
  final SpeedTrainingType type;

  const SpeedTrainingSummaryView(
      {super.key,
      required this.trainingConfig,
      required this.time,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisitcsCubit, StatisticsState>(
      builder: (context, state) {
        String text = 'Not Found';
        if (state is StatisticsInitial) {
          context.read<StatisitcsCubit>().getBestSpeedTrainingTime(type);
          return const SizedBox.shrink();
        } else if (state is StatisticsSuccessBestTime &&
            state.bestTime != null) {
          text = formatDuration(Duration(milliseconds: state.bestTime!));
        }

        return SummaryTemplate(
          imageConfig: TrainingImageConfig.fromSpeedType(type),
          title: trainingConfig.title,
          additionalInfo: [
            'Difficulty: ${trainingConfig.diffcultyText}',
            'Best time: $text'
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
                builder: (_) => SpeedTrainingPage(
                  trainingConfig: trainingConfig,
                  type: type,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
