import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_track/data/repositories/employee_repository.dart';
import 'package:flutter_work_track/presentation/cubit/employee_cubit.dart';
import 'package:flutter_work_track/routes/app_routes.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_styles.dart';

class WorkTrackApp extends StatelessWidget {
  const WorkTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmployeeCubit(employeeRepository: RepositoryProvider.of<EmployeeRepository>(context))), // Employee state management
      ],
      child: MaterialApp(
        title: 'Flutter Work Track',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        scaffoldMessengerKey: scaffoldMessengerKey,
        initialRoute: AppRoutes.home, // Start from Home Screen
        onGenerateRoute: AppRoutes.generateRoute, // Handle named routes
      ),
    );
  }
}
