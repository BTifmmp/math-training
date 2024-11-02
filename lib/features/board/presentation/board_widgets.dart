import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/board/cubit/board_cubit.dart';
import 'package:math_training/features/board/domain/board_box.dart';
import 'package:math_training/widgets/number_input/number_input.dart';

class Board extends StatelessWidget {
  final BoardMatrix? matrix;
  const Board({super.key, this.matrix});

  @override
  Widget build(BuildContext context) {
    if (matrix == null) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(builder: (context, constraints) {
      final int columns = matrix!.length;
      final int rows = columns > 0 ? matrix![0].length : 0;

      if (columns == 0 || rows == 0) {
        return const SizedBox.shrink();
      }

      final double ratio = columns / rows;

      final maxHeight = MediaQuery.of(context).size.height * 0.6;
      final double maxWidth = min(constraints.maxWidth, maxHeight * ratio);

      return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(children: [
            for (var row in matrix!)
              Row(children: [
                for (var box in row)
                  switch (box.type) {
                    BoardBoxType.empty => const BoardBoxEmpty(),
                    BoardBoxType.filledStatic =>
                      BoardBoxFilledStatic(text: box.data),
                    BoardBoxType.fillable => const BoardBoxFillable(),
                  }
              ])
          ]));
    });
  }
}

class BoardBoxEmpty extends StatelessWidget {
  const BoardBoxEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(child: Container());
  }
}

class BoardBoxFilledStatic extends StatelessWidget {
  final String? text;
  const BoardBoxFilledStatic({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Center(
              child: FittedBox(
                  child: Text(
                text ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8)),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class BoardBoxFillable extends StatefulWidget {
  const BoardBoxFillable({super.key});

  @override
  State<BoardBoxFillable> createState() => _BoardBoxFillableState();
}

class _BoardBoxFillableState extends State<BoardBoxFillable> {
  late NumberInputController numberContorller;
  double _scale = 1;
  bool _border = false;

  @override
  void initState() {
    numberContorller = NumberInputController();
    super.initState();
  }

  @override
  void dispose() {
    numberContorller.dispose();
    super.dispose();
  }

  void onFocusChange(bool isFocused) {
    if (isFocused) {
      context.read<BoardCubit>().changeController(numberContorller);
      setState(() {
        _scale = 1.05;
        _border = true;
      });
    } else {
      setState(() {
        _scale = 1;
        _border = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Focus(
          onFocusChange: onFocusChange,
          child: Builder(builder: (context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            return GestureDetector(
              onTap: () {
                if (hasFocus) {
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
              child: AnimatedScale(
                duration: const Duration(milliseconds: 100),
                scale: _scale,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: _border
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface)
                          : null,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                          child: ListenableBuilder(
                            listenable: numberContorller,
                            builder: (context, child) {
                              return Text(
                                numberContorller.value.isNotEmpty
                                    ? numberContorller.value
                                    : ' ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 19,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
