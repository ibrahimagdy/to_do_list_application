import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {
  static Color primaryColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      primary: primaryColor,
      onPrimary: Colors.white,
      primaryContainer: Colors.white,
      seedColor: primaryColor,
      onSecondary: const Color(0xff61E757),
      background: const Color(0xffDFECDB),
      scrim: Colors.black,
      outline: Colors.white,
      tertiary: primaryColor,
    ),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
      toolbarHeight: 140,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      selectedItemColor: primaryColor,
      unselectedIconTheme: const IconThemeData(
        color: Color(0xffC8C9CB),
        size: 32,
      ),
      unselectedItemColor: const Color(0xffC8C9CB),
    ),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primaryColor,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black,
        ),
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: const Color(0xff363636),
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
        primary: primaryColor,
        onPrimary: const Color(0xff060E1E),
        primaryContainer: Colors.white,
        seedColor: primaryColor,
        onSecondary: const Color(0xff61E757),
        background: const Color(0xff060E1E),
        scrim: Colors.white,
        outline: const Color(0xff141922),
        tertiary: Colors.white),
    scaffoldBackgroundColor: const Color(0xff060E1E),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Color(0xff060E1E),
      ),
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
      toolbarHeight: 140,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      selectedItemColor: primaryColor,
      unselectedIconTheme: const IconThemeData(
        color: Color(0xffC8C9CB),
        size: 32,
      ),
      unselectedItemColor: const Color(0xffC8C9CB),
    ),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: const Color(0xff060E1E),
        ),
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primaryColor,
        ),
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xff141922),
    ),
  );
}
