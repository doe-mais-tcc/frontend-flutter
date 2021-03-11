import 'package:flutter/material.dart';

ThemeData mainTheme() {
  const primary = Color(0xFFD11204);
  const accent = Color(0xFFD11204);
  const canvas = Color(0xFFF5F5F5);
  const normalText = Colors.black;
  const minText = Color(0xFF383838);
  const disabledText = Color(0xFF707070);
  const buttonText = Colors.white;

  return ThemeData(
    primaryColor: primary,
    accentColor: accent,
    canvasColor: canvas,
    buttonColor: primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: primary),
    ),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Montserrat',
        color: normalText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontFamily: 'Montserrat',
        color: normalText,
        fontSize: 20,
      ),
      headline3: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontSize: 18,
      ),
      bodyText1: TextStyle(
        color: normalText,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: minText,
        fontSize: 16,
      ),
      button: TextStyle(
        color: buttonText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        color: disabledText,
        fontSize: 14,
        fontWeight: FontWeight.w200,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: normalText),
    ),
    cardTheme: CardTheme(
      elevation: 5,
      shadowColor: Colors.black26,
    ),
  );
}