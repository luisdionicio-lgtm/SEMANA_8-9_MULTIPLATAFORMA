import 'package:flutter/material.dart';

const ink = Color(0xFFF1F4FF);
const forest = Color(0xFFA8B7FF);
const mint = Color(0xFF242F4A);
const muted = Color(0xFFAAB6CF);
const surface = Color(0xFF182238);
const line = Color(0xFF303B55);

// Tema global: centraliza color, tipografía y estados de todos los formularios.
ThemeData buildTheme() => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Manrope',
  scaffoldBackgroundColor: const Color(0xFF0D1426),
  colorScheme: ColorScheme.fromSeed(
    seedColor: forest,
    primary: forest,
    surface: surface,
    brightness: Brightness.dark,
    onPrimary: Color(0xFF0D1426),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.w800,
      color: ink,
      letterSpacing: -1.1,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: ink,
      letterSpacing: -.6,
    ),
    titleLarge: TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w800,
      color: ink,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: ink,
    ),
    bodyLarge: TextStyle(fontSize: 16, height: 1.65, color: muted),
    bodyMedium: TextStyle(fontSize: 13, height: 1.6, color: muted),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: line),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: line),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: forest, width: 2),
    ),
    labelStyle: const TextStyle(color: muted),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: forest,
      foregroundColor: const Color(0xFF0D1426),
      minimumSize: const Size(0, 50),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: forest,
      minimumSize: const Size(0, 50),
      side: const BorderSide(color: line),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: surface,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: line),
    ),
  ),
  dividerTheme: const DividerThemeData(color: line, thickness: 1),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyle(color: Color(0xFF0D1426)),
    backgroundColor: forest,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: forest,
    selectionColor: Color(0xFF435581),
    selectionHandleColor: forest,
  ),
);
