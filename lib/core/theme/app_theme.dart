import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    disabledColor: Colors.black12,
    fontFamily: "Poppins",
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    hoverColor: Colors.black12.withAlpha(5),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      surfaceTintColor: Colors.transparent,
      // backgroundColor: Config.baseClr,
      elevation: 0,
      // foregroundColor: Colors.white,
    ),
  );
}
