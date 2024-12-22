import 'package:flutter/material.dart';

var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
    seedColor: const Color.fromARGB(255, 39, 26, 216),
    contrastLevel: 0.6,
    brightness: Brightness.dark,
    surface: const Color.fromARGB(255, 20, 30, 43),
    surfaceContainer: const Color.fromARGB(255, 49, 65, 87),
    surfaceContainerHigh: const Color.fromARGB(255, 84, 96, 114),
    surfaceContainerLow: const Color.fromARGB(255, 43, 56, 75),
    onSurface: const Color.fromARGB(255, 255, 255, 255),
    onSurfaceVariant: const Color.fromARGB(255, 182, 196, 216),
    onSecondaryContainer: const Color.fromARGB(255, 143, 158, 179),
  ),
  appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(
    color: Color.fromARGB(255, 255, 255, 255),
  )),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  }),
  bottomSheetTheme: BottomSheetThemeData(
      dragHandleColor: Colors.white.withOpacity(0.3),
      dragHandleSize: const Size(50, 5)),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: const Color.fromARGB(255, 70, 93, 126),
    height: 60,
    labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w500,
        );
      } else {
        return const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 143, 158, 179),
        );
      }
    }),
    iconTheme: const WidgetStatePropertyAll<IconThemeData>(
      IconThemeData(
        color: Color.fromARGB(255, 255, 255, 255),
        size: 22,
      ),
    ),
  ),
);
