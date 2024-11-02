import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/game_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/board/cubit/board_cubit.dart';
import 'package:math_training/features/board/presentation/board_widgets.dart';
import 'package:math_training/features/math_crossword/cubit/math_crossword_cubit.dart';
import 'package:math_training/features/math_crossword/presentation/math_crossword_summary_view.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/stopwatch/cubit/stopwatch_cubit.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/widgets/number_input/number_input_small.dart';

class MathCrosswordPage extends StatelessWidget {
  final GameSize size;
  final GameType type;

  const MathCrosswordPage({super.key, required this.size, required this.type});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  MathCrosswordCubit()..generateCrossword(size)),
          BlocProvider(create: (context) => StopwatchCubit()..start()),
          BlocProvider<StatisitcsCubit>(
            create: (_) => StatisitcsCubit(
                statisticRepository: context.read<StatisticRepository>()),
          ),
          BlocProvider(create: (context) => BoardCubit()),
        ],
        child: MathCrosswordView(
          size: size,
          type: type,
        ));
  }
}

class MathCrosswordView extends StatelessWidget {
  final GameSize size;
  final GameType type;
  const MathCrosswordView({super.key, required this.size, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MathCrosswordCubit, MathCrosswordState>(
      listener: (context, state) async {
        if (state is MathCrossWordFinished) {
          var time = context.read<StopwatchCubit>().state.timeElapsed;

          await context
              .read<StatisitcsCubit>()
              .insertGameTime(GameTime(type: type, time: time.inMilliseconds));
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) =>
                    GameSummaryPage(size: size, time: time, type: type),
              ),
            );
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SpeedTrainingStopwatchDisplay(),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<MathCrosswordCubit, MathCrosswordState>(
                  builder: (context, state) {
                    return Board(
                      onValueChange: (value, id) {
                        var cubit = context.read<MathCrosswordCubit>();
                        cubit.submitAnswer(value, id);
                      },
                      matrix:
                          state is MathCrosswordGenerated ? state.matrix : null,
                    );
                  },
                ),
              ),
              const Spacer(flex: 3),
              BlocBuilder<BoardCubit, BoardState>(
                builder: (context, state) {
                  return NumberInputSmall(
                    controller: (state as BoardSelectedController).controller,
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  );
                },
              ),
            ],
          )),
    );
  }
}
