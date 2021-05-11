import 'package:flutter/material.dart';

ThemeData mainTheme() {
  const primary = Color(0xFFD11204);
  const accent = Color(0xFFD11204);
  const canvas = Color(0xFFF5F5F5);
  const normalText = Colors.black;
  const secondText = Color(0xFF707070);
  const minText = Color(0xFF383838);
  const disabled = Color(0xFF707070);
  const buttonText = Colors.white;
  const hoverColor = Color(0xFFF1F1F1);
  const linkColor = Colors.blue;

  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: accent,
      background: canvas,
    ),
    primaryColor: primary,
    buttonColor: primary,
    hoverColor: hoverColor,
    disabledColor: disabled,
    errorColor: primary,
    indicatorColor: minText,
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
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyText1: TextStyle(
        color: normalText,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: secondText,
        fontSize: 16,
      ),
      button: TextStyle(
        color: buttonText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        color: disabled,
        fontSize: 14,
        fontWeight: FontWeight.w200,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: linkColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: normalText),
    ),
    cardTheme: CardTheme(
      elevation: 5,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    dialogTheme: DialogTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: primary,
        side: BorderSide(color: primary),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: linkColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: linkColor)),
      labelStyle: TextStyle(color: minText),
    ),
  );
}
