import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/countdown/cubit/count_down_cubit.dart';
import 'package:math_training/features/countdown/presentation/countdown_widget.dart';
import 'package:math_training/features/stopwatch/cubit/stopwatch_cubit.dart';
import 'package:math_training/features/speed_training/cubit/speed_training_cubit.dart';
import 'package:math_training/widgets/number_input.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_summary_view.dart';
import 'package:math_training/utils/duration_formatter.dart';

class SpeedTrainingPage extends StatelessWidget {
  const SpeedTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SpeedTrainingCubit>(create: (_) => SpeedTrainingCubit()),
      BlocProvider<CountDownCubit>(
          create: (_) => CountDownCubit(count: 3)..start()),
      BlocProvider<StopwatchCubit>(create: (_) => StopwatchCubit()),
    ], child: const SpeedTrainingView());
  }
}

class SpeedTrainingView extends StatefulWidget {
  const SpeedTrainingView({super.key});

  @override
  State<SpeedTrainingView> createState() => _SpeedTrainingViewState();
}

class _SpeedTrainingViewState extends State<SpeedTrainingView> {
  final _numberInputController = NumberInputController();
  double _opacity = 0;

  @override
  void initState() {
    _numberInputController.addListener(() {
      // Submits every non empty input value as possible answer
      if (context.read<SpeedTrainingCubit>().state is SpeedTrainingRunning &&
          _numberInputController.value != '') {
        context
            .read<SpeedTrainingCubit>()
            .submitAnswer(num.parse(_numberInputController.value));
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
      backgroundColor: Colors.white,
      body: BlocListener<SpeedTrainingCubit, SpeedTrainingState>(
        listener: (context, state) {
          if (state is SpeedTrainingFinished) {
            // Pushes summary view if all task anwsered
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const SpeedTrainingSummaryView()));
          } else if (state is SpeedTrainingRunning &&
              !_numberInputController.clearScheduled &&
              (state.answerStatus == AnswerStatus.incorrect ||
                  state.answerStatus == AnswerStatus.correct)) {
            // Schedules a delayed number input clear if answer was
            // incorrect or correct and clear is not scheduled
            _numberInputController
                .delayedClear(const Duration(milliseconds: 200));
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpeedCurrentTaskDisplay(),
                  SpeedTrainingStopwatchDisplay(),
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
                  if (context.read<SpeedTrainingCubit>().state
                      is SpeedTrainingInitial) {
                    // Executes opacity change after frame has been build
                    // to ensure that animated task display exist
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _opacity = 1;
                      });
                    });
                    _numberInputController.clear();
                    context.read<SpeedTrainingCubit>().start();
                  }
                }
              },
              builder: (context, state) {
                return switch (state.runtimeType) {
                  const (CountDownFinished) => AnimatedSpeedTaskDisplay(
                      opacity: _opacity,
                      numberInputController: _numberInputController),
                  _ => Countdown(count: (state as CountDownCounting).count)
                };
              },
            ),
            const Spacer(),
            const SizedBox(height: 20),
            NumberInput(
              numberInputController: _numberInputController,
              backgroundColor: Colors.grey.shade200,
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: Colors.black,
          )),
      child: Row(
        children: [
          BlocBuilder<SpeedTrainingCubit, SpeedTrainingState>(
            builder: (context, state) {
              return AnimatedFlipCounter(
                value:
                    state is SpeedTrainingRunning ? state.currentTaskIndex : 0,
                textStyle: const TextStyle(fontSize: 18),
              );
            },
          ),
          Text(
            '/${context.select<SpeedTrainingCubit, String>((cubit) => cubit.state.totalTasksNumber.toString())}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class SpeedTrainingStopwatchDisplay extends StatelessWidget {
  const SpeedTrainingStopwatchDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: Colors.black,
          )),
      child: Text(
        formatDuration(
            context.select((StopwatchCubit bloc) => bloc.state.timeElapsed)),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class AnimatedSpeedTaskDisplay extends StatelessWidget {
  const AnimatedSpeedTaskDisplay({
    super.key,
    required double opacity,
    required NumberInputController numberInputController,
  })  : _opacity = opacity,
        _numberInputController = numberInputController;

  final double _opacity;
  final NumberInputController _numberInputController;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.easeInOut,
      opacity: _opacity,
      duration: const Duration(milliseconds: 150),
      child: Column(
        children: [
          BlocBuilder<SpeedTrainingCubit, SpeedTrainingState>(
            builder: (context, state) {
              return Text(
                state is SpeedTrainingRunning ? state.currentTaskText : '',
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
              );
            },
          ),
          const SizedBox(height: 20),
          NumberInputValueDisplay(
            numberInputController: _numberInputController,
          ),
        ],
      ),
    );
  }
}
