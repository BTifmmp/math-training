import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/common/cubits/countdown/count_down_cubit.dart';
import 'package:math_training/common/cubits/stopwatch/stopwatch_cubit.dart';
import 'package:math_training/features/speed_training/cubit/speed_training_cubit.dart';
import 'package:math_training/common/widgets/number_input.dart';
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
  StreamSubscription? _cubitStreamSubscription;
  double _opacity = 0;

  @override
  void initState() {
    _cubitStreamSubscription =
        context.read<SpeedTrainingCubit>().stream.listen((state) async {
      if (state is SpeedTrainingFinished) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => const SpeedTrainingSummaryView()));
        }
      } else if (state is SpeedTrainingRunning &&
          !_numberInputController.clearScheduled) {
        if (state.answerStatus == AnswerStatus.incorrect ||
            state.answerStatus == AnswerStatus.correct) {
          _numberInputController
              .delayedClear(const Duration(milliseconds: 200));
        }
      }
    });

    _numberInputController.addListener(() {
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
    _cubitStreamSubscription?.cancel();
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                            value: state is SpeedTrainingRunning
                                ? state.currentTaskIndex
                                : 0,
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
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Text(
                    context.select((StopwatchCubit bloc) =>
                        formatDuration(bloc.state.timeElapsed)),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          BlocConsumer<CountDownCubit, CountDownState>(
            listener: (context, state) {
              if (state is CountDownFinished) {
                if (context.read<StopwatchCubit>().state is StopwatchInitial) {
                  context.read<StopwatchCubit>().start();
                }
                if (context.read<SpeedTrainingCubit>().state
                    is SpeedTrainingInitial) {
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
              if (state is CountDownFinished) {
                return AnimatedOpacity(
                  curve: Curves.easeInOut,
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 150),
                  child: Column(
                    children: [
                      BlocBuilder<SpeedTrainingCubit, SpeedTrainingState>(
                        builder: (context, state) {
                          return Text(
                            state is SpeedTrainingRunning
                                ? state.currentTaskText
                                : '',
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w300),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      NumberInputValueDisplayer(
                        numberInputController: _numberInputController,
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Center(
                    child: AnimatedFlipCounter(
                      value: (state as CountDownCounting).count,
                      textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                );
              }
            },
          ),
          const Spacer(),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.only(top: 20),
            child: NumberInput(
              numberInputController: _numberInputController,
            ),
          ),
        ],
      ),
    );
  }
}
