import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/stopwatch/cubit/stopwatch_cubit.dart';
import 'package:math_training/utils/duration_formatter.dart';

class StopwatchDisplay extends StatelessWidget {
  const StopwatchDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        formatDuration(
            context.select((StopwatchCubit cubit) => cubit.state.timeElapsed)),
        style: TextStyle(
            fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
