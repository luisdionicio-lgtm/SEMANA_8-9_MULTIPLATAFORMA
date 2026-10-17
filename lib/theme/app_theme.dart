import 'package:flutter/material.dart';

const ink = Color(0xFF10110C),
    forest = Color(0xFF4930F4),
    mint = Color(0xFFD8FF22),
    muted = Color(0xFF55564D),
    surface = Color(0xFFF8F8EF),
    line = Color(0xFF10110C),
    coral = Color(0xFFFF593D),
    cyan = Color(0xFF25D9E8);
ThemeData buildTheme() => ThemeData(
  useMaterial3: true,
  fontFamily: 'Manrope',
  scaffoldBackgroundColor: forest,
  colorScheme: ColorScheme.fromSeed(
    seedColor: forest,
    primary: ink,
    onPrimary: mint,
    surface: surface,
    onSurface: ink,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.w900,
      color: ink,
      height: 1,
      letterSpacing: -1.2,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: ink,
      height: 1.1,
      letterSpacing: -.7,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: ink,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: ink,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: ink, height: 1.4),
    bodyMedium: TextStyle(fontSize: 13, color: muted, height: 1.5),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: ink, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: ink, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: forest, width: 3),
    ),
    labelStyle: const TextStyle(color: muted),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: ink,
      foregroundColor: mint,
      minimumSize: const Size(0, 50),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      textStyle: const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w900,
        fontSize: 15,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ink,
      minimumSize: const Size(0, 48),
      side: const BorderSide(color: ink, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: surface,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: ink, width: 2),
    ),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: surface,
    indicatorColor: mint,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        fontFamily: 'Manrope',
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(color: Color(0xFFBCBDB1)),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: ink,
    contentTextStyle: TextStyle(color: mint),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: forest,
    selectionColor: Color(0xFFCAC2FF),
    selectionHandleColor: forest,
  ),
);
