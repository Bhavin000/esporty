import 'package:flutter/material.dart';

abstract class AppTheme {
  get themeData;
}

class LightTheme extends AppTheme {
  @override
  get themeData => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
        ),
        canvasColor: const Color.fromRGBO(240, 240, 240, 1),
        cardTheme: const CardTheme(
          color: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            color: Colors.grey,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 18),
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
}

class DarkTheme extends AppTheme {
  @override
  get themeData => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
        ),
        canvasColor: const Color.fromRGBO(20, 20, 20, 1),
        cardTheme: const CardTheme(
          color: Color.fromRGBO(40, 40, 40, 1),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            color: Colors.white,
          ),
          subtitle2: TextStyle(
            color: Colors.grey,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 18),
          fillColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
}
