import 'package:flutter/material.dart';

ColorScheme _colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff97ce4c),
  brightness: Brightness.dark,
  dynamicSchemeVariant: DynamicSchemeVariant.fruitSalad,
);

ThemeData theme = ThemeData(
  colorScheme: _colorScheme,
  scaffoldBackgroundColor: _colorScheme.surfaceBright,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white38;
        }
        return null;
      }),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
  ),
);
