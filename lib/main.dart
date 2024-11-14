import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_training/app.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 20, 30, 43),
      systemNavigationBarColor: const Color.fromARGB(255, 20, 30, 43),
    ),
  );

  StatisticRepository statisticRepository = StatisticRepository();

  runApp(App(
    statisticRepository: statisticRepository,
  ));
}
