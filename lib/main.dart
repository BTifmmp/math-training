import 'package:flutter/material.dart';
import 'package:math_training/app.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  StatisticRepository statisticRepository = StatisticRepository();

  runApp(App(
    statisticRepository: statisticRepository,
  ));
}
