import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/utils/duration_formatter.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<StatisitcsCubit, StatisticsState>(
        builder: (context, state) {
          String text = 'Not Found';
          if (state is StatisticsInitial) {
            context.read<StatisitcsCubit>().getBestSpeedTrainingTime(type);
            return const SizedBox.shrink();
          } else if (state is StatisticsSuccessBestTime &&
              state.bestTime != null) {
            text = formatDuration(Duration(milliseconds: state.bestTime!));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    trainingConfig.title,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.w600, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text('Difficulty: ${trainingConfig.diffcultyText}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300)),
                  Text('Best time: $text',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300)),
                  const Spacer(flex: 1),
                  SizedBox(
                    width: 250,
                    child: Card.filled(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
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
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurfaceVariant),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => SpeedTrainingPage(
                            trainingConfig: trainingConfig,
                            type: type,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Text(
                        'Play Again',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Spacer(flex: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
