import 'package:flutter/foundation.dart';
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
      fontSize: spRes(20), // Using ScreenUtil for scaling
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: wRes(16), vertical: hRes(12)), // Scaled padding
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    titleLarge: GoogleFonts.roboto(fontSize: spRes(18), fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.roboto(fontSize: spRes(16), fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.roboto(fontSize: spRes(14), fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.roboto(fontSize: spRes(16), fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.roboto(fontSize: spRes(15), fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.roboto(fontSize: spRes(12), fontWeight: FontWeight.w400),
    displayMedium: GoogleFonts.roboto(fontSize: spRes(14), fontWeight: FontWeight.w500),
  ),
);


double spRes(double size) => kIsWeb?size:size.sp;

double wRes(double size) => kIsWeb?size:size.w;

double hRes(double size) => kIsWeb?size:size.h;