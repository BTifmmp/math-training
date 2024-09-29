import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/presentation/speed_trainings_list_view.dart';
import 'package:math_training/features/trainings/presentation/mental_trainings_list_view.dart';
import 'package:math_training/utils/custom_icons.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late int _currentPageIndex;
  late PageController _pageController;

  @override
  void initState() {
    _currentPageIndex = 0;
    _pageController = PageController(initialPage: _currentPageIndex);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.1),
            ),
          ),
        ),
        child: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            onDestinationSelected: (int index) {
              setState(() {
                _currentPageIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            selectedIndex: _currentPageIndex,
            destinations: <Widget>[
              NavigationDestination(
                icon: AnimatedCrossFade(
                  crossFadeState: _currentPageIndex == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                  firstChild: const Icon(CustomIcons.bolt_filled),
                  secondChild: Icon(
                    CustomIcons.bolt_outlined,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                label: 'Speed',
              ),
              NavigationDestination(
                icon: AnimatedCrossFade(
                  crossFadeState: _currentPageIndex == 1
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                  firstChild: const Icon(CustomIcons.brain_filled),
                  secondChild: Icon(CustomIcons.brain_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                label: 'Mental',
              ),
            ]),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: const <Widget>[
            SpeedTrainingsListView(),
            MentalTrainingsListView(),
          ],
        ),
      ),
    );
  }
}
