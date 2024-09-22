import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/presentation/speed_trainings_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Speed',
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Mental',
            ),
          ]),
      body: SafeArea(
        child: <Widget>[
          const SpeedTrainingsListView(),
          const SpeedTrainingsListView()
        ][currentPageIndex],
      ),
    );
  }
}
