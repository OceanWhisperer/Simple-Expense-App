import 'package:flutter/material.dart';
import 'package:expenseapp/expenses.dart';

var kcolorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kdarkscheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  return runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kdarkscheme,
      cardTheme: const CardTheme().copyWith(
        color: kdarkscheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: kdarkscheme.onPrimaryContainer,
            backgroundColor: kdarkscheme.primaryContainer),
      ),
    ),
    theme: ThemeData().copyWith(
      colorScheme: kcolorscheme,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorscheme.onPrimaryContainer,
          foregroundColor: kcolorscheme.primaryContainer),
      cardTheme: const CardTheme().copyWith(
        color: kcolorscheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kcolorscheme.primaryContainer),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kcolorscheme.onSecondaryContainer,
                fontSize: 16),
          ),
    ),
    debugShowCheckedModeBanner: false,
    home: const Expenses(),
  ));
}
