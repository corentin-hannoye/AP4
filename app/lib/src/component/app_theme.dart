import 'package:app/src/const.dart';
import 'package:flutter/material.dart';

ThemeData appThemeData() {
  return ThemeData(
    fontFamily: 'Montserrat',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: whiteColor,
      secondary: secondaryColor,
      error: errorColor
    ),
    disabledColor: disabledColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900
      ),
      displayMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900
      ),
      labelSmall: TextStyle(
        fontSize: 16,
        decoration: TextDecoration.underline,
        decorationColor: linkColor,
        color: linkColor
      )
    )
  );
}
