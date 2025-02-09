import 'package:flutter/material.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppColors.whiteTextColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryBlue,
    elevation: 2,
    titleTextStyle: TextStyle(
      color: AppColors.whiteTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    titleLarge: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
    displayMedium: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
  ),
);