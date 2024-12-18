import 'package:flutter/material.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/trainings/presentation/home_view.dart';
import 'package:math_training/themes/dark_theme.dart';

class App extends StatelessWidget {
  final StatisticRepository _statisticRepository;

  const App({super.key, required StatisticRepository statisticRepository})
      : _statisticRepository = statisticRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _statisticRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeView(),
    );
  }
}
