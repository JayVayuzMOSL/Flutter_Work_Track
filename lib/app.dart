import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/routes/app_routes.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_styles.dart';

class WorkTrackApp extends StatelessWidget {
  const WorkTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780), // Set base design size
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Work Track',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          scaffoldMessengerKey: scaffoldMessengerKey,
          initialRoute: AppRoutes.home, // Start from Home Screen
          onGenerateRoute: AppRoutes.generateRoute, // Handle named routes
        );
      },
    );
  }
}
