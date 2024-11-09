import 'package:flutter/material.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_training/features/trainings/presentation/home_view.dart';

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
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
            seedColor: const Color.fromARGB(255, 39, 26, 216),
            contrastLevel: 0.6,
            brightness: Brightness.dark,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(
                allowEnterRouteSnapshotting: false,
              ),
            },
          ),
          bottomSheetTheme: BottomSheetThemeData(
              dragHandleColor: Colors.white.withOpacity(0.3),
              dragHandleSize: const Size(50, 5)),
          navigationBarTheme: const NavigationBarThemeData(
              indicatorColor: Color.fromARGB(255, 50, 54, 63),
              height: 60,
              iconTheme: WidgetStatePropertyAll<IconThemeData>(IconThemeData(
                size: 20,
              )))),
      themeMode: ThemeMode.dark,
      home: const HomeView(),
    );
  }
}
