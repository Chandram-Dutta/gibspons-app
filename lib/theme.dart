import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  cardColor: Colors.white,
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color.fromRGBO(25, 25, 25, 1),
    indicatorColor: Color.fromRGBO(83, 121, 246, 1),
    iconTheme: MaterialStatePropertyAll(
      IconThemeData(
        color: Colors.white,
      ),
    ),
    labelTextStyle: MaterialStatePropertyAll(
      TextStyle(
        color: Colors.white,
      ),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  fontFamily: GoogleFonts.outfit().fontFamily,
  filledButtonTheme: FilledButtonThemeData(style: primaryLightButtonStyle),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(83, 121, 246, 1),
    onPrimary: Colors.white,
    primaryContainer: Color.fromRGBO(25, 25, 25, 1),
    secondary: Color.fromRGBO(228, 231, 235, 1),
    onSecondary: Color.fromRGBO(75, 87, 104, 1),
    secondaryContainer: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Color.fromRGBO(244, 245, 247, 1),
    onBackground: Color.fromRGBO(66, 66, 66, 1),
    surface: Colors.white,
    onSurface: Color.fromRGBO(36, 36, 36, 1),
  ),
);

final primaryLightButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);

final secondaryLightButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  backgroundColor: MaterialStateProperty.all(
    const Color.fromRGBO(228, 231, 235, 1),
  ),
  foregroundColor: MaterialStateProperty.all(
    const Color.fromRGBO(75, 87, 104, 1),
  ),
);
