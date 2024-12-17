import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/countdown/cubit/count_down_cubit.dart';
import 'package:math_training/features/countdown/presentation/countdown_widget.dart';
import 'package:math_training/features/mental_training/cubit/mental_training_cubit.dart';
import 'package:math_training/features/mental_training/presentation/mental_training_summary_view.dart';
import 'package:math_training/features/trainings/constants/training_config.dart';
import 'package:math_training/widgets/number_input/number_input.dart';
import 'package:math_training/widgets/number_input/number_input_controller.dart';
import 'package:math_training/widgets/number_input/value_display.dart';

class MentalTrainingPage extends StatelessWidget {
  final TrainingConfig trainingConfig;

  const MentalTrainingPage({super.key, required this.trainingConfig});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MentalTrainingCubit>(
          create: (_) => MentalTrainingCubit(trainingConfig: trainingConfig)),
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
      if (context.read<MentalTrainingCubit>().state
              is MentalTrainingWaitingForAnswer &&
          _numberInputController.value != '') {
        context
            .read<MentalTrainingCubit>()
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
      body: BlocConsumer<MentalTrainingCubit, MentalTrainingState>(
        listener: (context, state) {
          if (state is MentalTrainingFinished) {
            // Pushes summary view if all task anwsered
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => MentalTrainingSummaryView(
                      isAnswerCorrect: state.isAnswerCorrect,
                      trainingConfig: state.trainingConfig,
                      correctAnswer: state.correctAnswer,
                    )));
          } else if (state is MentalTrainingWaitingForAnswer &&
              (state.answerStatus == AnswerStatus.incorrect ||
                  state.answerStatus == AnswerStatus.correct)) {
            // Schedules a delayed number input clear if answer was
            // incorrect or correct and clear is not scheduled
            _numberInputController
                .delayedClear(const Duration(milliseconds: 200));
          }
        },
        builder: (BuildContext context, MentalTrainingState state) {
          if (state is MentalTrainingFinished) {
            return const SizedBox.shrink();
          } else if (state is MentalTrainingWaitingForAnswer) {
            return Column(
              children: [
                const Spacer(flex: 1),
                const Text('Your Answer', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 5),
                AnswerTriesDisplay(availableTries: state.availableTries),
                const Spacer(flex: 1),
                NumberInputValueDisplay(
                    numberInputController: _numberInputController),
                const Spacer(flex: 2),
                NumberInput(
                  numberInputController: _numberInputController,
                ),
              ],
            );
          } else {
            return BlocConsumer<CountDownCubit, CountDownState>(
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
                  const (CountDownFinished) => Column(
                      children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              MentalCurrentTaskDisplay(),
                              Spacer(),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),
                        AnimatedMentalTaskDisplay(
                          opacity: _opacity,
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  _ => Column(
                      children: [
                        const SizedBox(height: 50),
                        const Spacer(flex: 1),
                        Center(
                            child: Countdown(
                                count: (state as CountDownCounting).count)),
                        const Spacer(flex: 2),
                      ],
                    )
                };
              },
            );
          }
        },
      ),
    );
  }
}

class AnswerTriesDisplay extends StatelessWidget {
  final int availableTries;
  const AnswerTriesDisplay({
    super.key,
    required this.availableTries,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Tries',
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(width: 10),
        Icon(availableTries < 3 ? Icons.cancel : Icons.circle_outlined,
            size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
        Icon(
          availableTries < 2 ? Icons.cancel : Icons.circle_outlined,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        Icon(
          availableTries < 1 ? Icons.cancel : Icons.circle_outlined,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
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
        color: Theme.of(context).colorScheme.surfaceContainer,
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
