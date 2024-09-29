import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/countdown/cubit/count_down_cubit.dart';
import 'package:math_training/features/countdown/presentation/countdown_widget.dart';
import 'package:math_training/features/mental_training/cubit/mental_training_cubit.dart';
import 'package:math_training/widgets/number_input.dart';

class MentalTrainingPage extends StatelessWidget {
  const MentalTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MentalTrainingCubit>(create: (_) => MentalTrainingCubit()),
      BlocProvider<CountDownCubit>(
          create: (_) => CountDownCubit(count: 3)..start()),
    ], child: const MentalTrainingView());
  }
}

class MentalTrainingView extends StatefulWidget {
  const MentalTrainingView({super.key});

  @override
  State<MentalTrainingView> createState() => _MentalTrainingViewState();
}

class _MentalTrainingViewState extends State<MentalTrainingView> {
  final _numberInputController = NumberInputController();
  double _opacity = 0;

  @override
  void initState() {
    _numberInputController.addListener(() {
      // Submits every non empty input value as possible answer
      if (context.read<MentalTrainingCubit>().state is MentalTrainingRunning &&
          _numberInputController.value != '') {
        context
            .read<MentalTrainingCubit>()
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
      body: BlocListener<MentalTrainingCubit, MentalTrainingState>(
        listener: (context, state) {
          // if (state is MentalTrainingFinished) {
          //   // Pushes summary view if all task anwsered
          //   Navigator.of(context).pushReplacement(MaterialPageRoute(
          //       fullscreenDialog: true,
          //       builder: (_) => const MentalTrainingSummaryView()));
          // } else if (state is MentalTrainingRunning &&
          //     !_numberInputController.clearScheduled &&
          //     (state.answerStatus == AnswerStatus.incorrect ||
          //         state.answerStatus == AnswerStatus.correct)) {
          //   // Schedules a delayed number input clear if answer was
          //   // incorrect or correct and clear is not scheduled
          //   _numberInputController
          //       .delayedClear(const Duration(milliseconds: 200));
          // }
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  MentalCurrentTaskDisplay(),
                ],
              ),
            ),
            const Spacer(flex: 1),
            BlocConsumer<CountDownCubit, CountDownState>(
              listener: (context, state) {
                // Checks if countdown has finished
                if (state is CountDownFinished) {
                  if (context.read<MentalTrainingCubit>().state
                      is MentalTrainingInitial) {
                    // Executes opacity change after frame has been build
                    // to ensure that animated task display exist
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _opacity = 1;
                      });
                    });
                    _numberInputController.clear();
                    context.read<MentalTrainingCubit>().start();
                  }
                }
              },
              builder: (context, state) {
                return switch (state.runtimeType) {
                  const (CountDownFinished) => AnimatedMentalTaskDisplay(
                      opacity: _opacity,
                    ),
                  _ => Countdown(count: (state as CountDownCounting).count)
                };
              },
            ),
            const Spacer(flex: 2),
            BlocBuilder<MentalTrainingCubit, MentalTrainingState>(
              buildWhen: (previous, current) =>
                  current is MentalTrainingWaitingForAnswer,
              builder: (context, state) {
                return state is MentalTrainingWaitingForAnswer
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          NumberInput(
                            numberInputController: _numberInputController,
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}

class MentalCurrentTaskDisplay extends StatelessWidget {
  const MentalCurrentTaskDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          BlocBuilder<MentalTrainingCubit, MentalTrainingState>(
            builder: (context, state) {
              return AnimatedFlipCounter(
                value:
                    state is MentalTrainingRunning ? state.currentTaskIndex : 0,
                textStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface),
              );
            },
          ),
          Text(
            '/${context.select<MentalTrainingCubit, String>((cubit) => cubit.state.totalTasksNumber.toString())}',
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

class AnimatedMentalTaskDisplay extends StatelessWidget {
  const AnimatedMentalTaskDisplay({
    super.key,
    required double opacity,
  }) : _opacity = opacity;

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.easeInOut,
      opacity: _opacity,
      duration: const Duration(milliseconds: 150),
      child: Column(
        children: [
          BlocBuilder<MentalTrainingCubit, MentalTrainingState>(
            builder: (context, state) {
              return Text(
                state is MentalTrainingRunning ? state.currentTaskText : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.onSurface),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
