import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/board/cubit/board_cubit.dart';
import 'package:math_training/features/board/domain/board_box.dart';
import 'package:math_training/features/board/presentation/board_widgets.dart';
import 'package:math_training/features/math_crossword/cubit/math_crossword_cubit.dart';
import 'package:math_training/features/speed_training/presentation/speed_training_view.dart';
import 'package:math_training/features/stopwatch/cubit/stopwatch_cubit.dart';
import 'package:math_training/features/trainings/domain/training_config.dart';
import 'package:math_training/widgets/number_input/number_input_small.dart';

class MathCrosswordPage extends StatelessWidget {
  final GameSize size;
  const MathCrosswordPage({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => MathCrosswordCubit()..generateCrossword(size)),
      BlocProvider(create: (context) => StopwatchCubit()..start()),
      BlocProvider(create: (context) => BoardCubit()),
    ], child: const MathCrosswordView());
  }
}

class MathCrosswordView extends StatelessWidget {
  const MathCrosswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  print(state);
                  return state is MathCrosswordGenerated
                      ? Board(matrix: state.matrix)
                      : Board(matrix: [
                          [
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('-'),
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('='),
                            BoardBoxInfo.filledStatic('20'),
                          ],
                          [
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('-'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.empty(),
                          ],
                          [
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('-'),
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('='),
                            BoardBoxInfo.filledStatic('20'),
                          ],
                          [
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('-'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.empty(),
                          ],
                          [
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('+'),
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('-'),
                            BoardBoxInfo.fillable(0),
                            BoardBoxInfo.filledStatic('='),
                            BoardBoxInfo.filledStatic('20'),
                          ],
                          [
                            BoardBoxInfo.filledStatic('='),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('='),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('='),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.empty(),
                          ],
                          [
                            BoardBoxInfo.filledStatic('12'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('11'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.filledStatic('56'),
                            BoardBoxInfo.empty(),
                            BoardBoxInfo.empty(),
                          ],
                        ]);
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
        ));
  }
}
