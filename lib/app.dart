import 'package:flutter/material.dart';
import 'package:math_training/features/statictics/cubit/statistics_cubit.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/trainings/presentation/home_view.dart';

class App extends StatelessWidget {
  final StatisticRepository _statisticRepository;

  const App({super.key, required StatisticRepository statisticRepository})
      : _statisticRepository = statisticRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StatisitcsCubit(statisticRepository: _statisticRepository),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}
