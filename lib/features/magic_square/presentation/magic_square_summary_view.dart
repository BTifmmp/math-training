import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/math_crossword/presentation/math_crossword_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/utils/duration_formatter.dart';

class MagicSquareSummaryPage extends StatelessWidget {
  final GameSize size;
  final Duration time;
  final GameType type;

  const MagicSquareSummaryPage(
      {super.key, required this.size, required this.time, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisitcsCubit>(
      create: (_) => StatisitcsCubit(
          statisticRepository: context.read<StatisticRepository>()),
      child: MagicSquareSummaryView(size: size, time: time, type: type),
    );
  }
}

class MagicSquareSummaryView extends StatelessWidget {
  final GameSize size;
  final Duration time;
  final GameType type;

  const MagicSquareSummaryView(
      {super.key, required this.size, required this.time, required this.type});

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
            context.read<StatisitcsCubit>().getBestGameTime(type);
            return const SizedBox.shrink();
          } else if (state is StatisticsSuccessBestTimeGame &&
              state.bestTimeGame != null) {
            text = formatDuration(Duration(milliseconds: state.bestTimeGame!));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(flex: 2),
                  const Text(
                    'Magic Square',
                    style: TextStyle(
                        fontSize: 35, fontWeight: FontWeight.w600, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text('Size: ${(size == GameSize.small ? "Small" : "Big")}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300)),
                  Text('Best time: $text',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300)),
                  const Spacer(flex: 2),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurfaceVariant),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => MathCrosswordPage(
                            size: size,
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
