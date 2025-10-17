import 'package:flutter/material.dart';

ThemeData getTheme(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xff97ce4c),
    brightness: brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.fruitSalad,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surfaceBright,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white38;
          }
          return null;
        }),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.comfortable,
      ),
    ),
  );
}
