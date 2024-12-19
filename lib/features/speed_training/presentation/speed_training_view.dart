import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/database/models/speed_training_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/countdown/cubit/count_down_cubit.dart';
import 'package:math_training/features/countdown/presentation/countdown_widget.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:math_training/features/stopwatch/cubit/stopwatch_cubit.dart';
import 'package:math_training/features/speed_training/cubit/speed_training_cubit.dart';
import 'package:math_training/features/stopwatch/presentation/stopwatch_display.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/features/trainings/presentation/widgets/top_down_switcher.dart';
import 'package:math_training/widgets/number_input/number_input.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_summary_view.dart';
import 'package:math_training/widgets/number_input/number_input_controller.dart';
import 'package:math_training/widgets/number_input/value_display.dart';

class SpeedTrainingPage extends StatelessWidget {
  final TrainingConfig trainingConfig;
  final SpeedTrainingType type;

  const SpeedTrainingPage(
      {super.key, required this.trainingConfig, required this.type});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SpeedTrainingCubit>(
          create: (_) => SpeedTrainingCubit(trainingConfig: trainingConfig)),
      BlocProvider<CountDownCubit>(
          create: (_) => CountDownCubit(count: 3)..start()),
      BlocProvider<StopwatchCubit>(create: (_) => StopwatchCubit()),
      BlocProvider<StatisitcsCubit>(
        create: (_) => StatisitcsCubit(
            statisticRepository: context.read<StatisticRepository>()),
      )
    ], child: SpeedTrainingView(type: type));
  }
}

class SpeedTrainingView extends StatefulWidget {
  final SpeedTrainingType type;
  const SpeedTrainingView({super.key, required this.type});

  @override
  State<SpeedTrainingView> createState() => _SpeedTrainingViewState();
}

class _SpeedTrainingViewState extends State<SpeedTrainingView> {
  final _numberInputController = NumberInputController();
  Widget _taskDisplay = const SizedBox.shrink();

  @override
  void initState() {
    _numberInputController.addListener(() {
      // Submits every non empty input value as possible answer
      if (context.read<SpeedTrainingCubit>().state is SpeedTrainingRunning &&
          _numberInputController.value != '') {
        context
            .read<SpeedTrainingCubit>()
            .submitAnswer(_numberInputController.value);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _numberInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<SpeedTrainingCubit, SpeedTrainingState>(
        listener: (context, speedState) async {
          if (speedState is SpeedTrainingFinished) {
            final time = context.read<StopwatchCubit>().state.timeElapsed;

            await context.read<StatisitcsCubit>().insertSpeedTrainingTime(
                SpeedTrainingTime(
                    type: widget.type, time: time.inMilliseconds));

            // Pushes summary view if all task anwsered
            if (context.mounted) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => SpeedTrainingSummaryPage(
                        trainingConfig: speedState.trainingConfig,
                        time: time,
                        type: widget.type,
                      )));
            }
          } else if (speedState is SpeedTrainingRunning &&
              (speedState.answerStatus == AnswerStatus.incorrect ||
                  speedState.answerStatus == AnswerStatus.correct)) {
            // Schedules a delayed number input clear if answer was
            // incorrect or correct and clear is not scheduled
            _numberInputController
                .delayedClear(const Duration(milliseconds: 200));
          }

          if (speedState is SpeedTrainingRunning) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _taskDisplay = Text(
                  key: ValueKey(speedState.currentTaskIndex),
                  speedState.currentTaskText,
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.onSurface),
                );
              });
            });
          }
        },
        builder: (BuildContext context, SpeedTrainingState speedState) {
          if (speedState is SpeedTrainingFinished) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SpeedCurrentTaskDisplay(),
                    StopwatchDisplay(),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<CountDownCubit, CountDownState>(
                listener: (context, state) {
                  // Checks if countdown has finished
                  if (state is CountDownFinished) {
                    if (context.read<StopwatchCubit>().state
                        is StopwatchInitial) {
                      context.read<StopwatchCubit>().start();
                    }
                    if (speedState is SpeedTrainingInitial) {
                      _numberInputController.clear();
                      context.read<SpeedTrainingCubit>().start();
                    }
                  }
                },
                builder: (context, state) {
                  return switch (state.runtimeType) {
                    const (CountDownFinished) => Column(
                        children: [
                          TopDownSwitcher(
                            offsetVertical: 0.15,
                            newChildKey: ValueKey(
                                (speedState as SpeedTrainingRunning)
                                    .currentTaskIndex),
                            child: _taskDisplay,
                          ),
                          const SizedBox(height: 20),
                          NumberInputValueDisplay(
                            numberInputController: _numberInputController,
                          ),
                        ],
                      ),
                    _ => Countdown(count: (state as CountDownCounting).count)
                  };
                },
              ),
              const Spacer(),
              const SizedBox(height: 20),
              NumberInput(
                numberInputController: _numberInputController,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SpeedCurrentTaskDisplay extends StatelessWidget {
  const SpeedCurrentTaskDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          BlocBuilder<SpeedTrainingCubit, SpeedTrainingState>(
            builder: (context, state) {
              return AnimatedFlipCounter(
                value:
                    state is SpeedTrainingRunning ? state.currentTaskIndex : 0,
                textStyle: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface),
              );
            },
          ),
          Text(
            '/${context.select<SpeedTrainingCubit, String>((cubit) => cubit.state.totalTasksNumber.toString())}',
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
