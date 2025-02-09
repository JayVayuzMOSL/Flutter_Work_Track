import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppColors.whiteTextColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryBlue,
    elevation: 2,
    titleTextStyle: TextStyle(
      color: AppColors.whiteTextColor,
      fontSize: 20.sp, // Using ScreenUtil for scaling
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h), // Scaled padding
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    titleLarge: GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.roboto(fontSize: 14.sp, fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.roboto(fontSize: 12.sp, fontWeight: FontWeight.w400),
    displayMedium: GoogleFonts.roboto(fontSize: 14.sp, fontWeight: FontWeight.w500),
  ),
);
