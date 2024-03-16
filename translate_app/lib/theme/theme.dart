import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(254, 255, 255, 255),
    secondary: Color.fromARGB(230, 0, 110, 255),
    tertiary: Color.fromARGB(255, 29, 29, 28)
  )
);
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 37, 36, 36),
    secondary: Color.fromARGB(230, 7, 212, 171),
    tertiary: Colors.white
  )
);

