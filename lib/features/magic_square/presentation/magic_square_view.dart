import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/game_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/board/cubit/board_cubit.dart';
import 'package:math_training/features/board/presentation/board_widgets.dart';
import 'package:math_training/features/magic_square/cubit/magic_square_cubit.dart';
import 'package:math_training/features/magic_square/presentation/magic_square_summary_view.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/stopwatch/cubit/stopwatch_cubit.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/widgets/number_input/number_input_small.dart';

class MagicSquarePage extends StatelessWidget {
  final GameSize size;
  final GameType type;

  const MagicSquarePage({super.key, required this.size, required this.type});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  MagicSquareCubit()..generateMagicSquare(size)),
          BlocProvider(create: (context) => StopwatchCubit()..start()),
          BlocProvider<StatisitcsCubit>(
            create: (_) => StatisitcsCubit(
                statisticRepository: context.read<StatisticRepository>()),
          ),
          BlocProvider(create: (context) => BoardCubit()),
        ],
        child: MagicSquareView(
          size: size,
          type: type,
        ));
  }
}

class MagicSquareView extends StatelessWidget {
  final GameSize size;
  final GameType type;
  const MagicSquareView({super.key, required this.size, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MagicSquareCubit, MagicSquareState>(
      listener: (context, state) async {
        if (state is MagicSquareFinished) {
          var time = context.read<StopwatchCubit>().state.timeElapsed;

          await context
              .read<StatisitcsCubit>()
              .insertGameTime(GameTime(type: type, time: time.inMilliseconds));
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) =>
                    MagicSquareSummaryPage(size: size, time: time, type: type),
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
                child: BlocBuilder<MagicSquareCubit, MagicSquareState>(
                  builder: (context, state) {
                    return Board(
                      onValueChange: (value, id) {
                        var cubit = context.read<MagicSquareCubit>();
                        cubit.submitAnswer(value, id);
                      },
                      matrix:
                          state is MagicSquareGenerated ? state.matrix : null,
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
