import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_track/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:flutter_work_track/presentation/cubit/employee_cubit.dart';
import 'package:flutter_work_track/presentation/views/employee_list_screen.dart';
import 'package:flutter_work_track/presentation/views/add_edit_employee.dart';
import 'package:flutter_work_track/service_locator.dart';

class AppRoutes {
  static const String home = '/';
  static const String addEditEmployee = '/addEditEmployee';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<EmployeeCubit>()..loadEmployees(),
            child: EmployeeListScreen(),
          ),
        );

      case addEditEmployee:
        final args = settings.arguments as Map<String, dynamic>?; // Passing data if needed
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<AddEditEmployeeCubit>(param1: args?['employee'])),
    BlocProvider(
    create: (_) => getIt<EmployeeCubit>()..loadEmployees()),
            ],
            child: AddEditEmployeeScreen(employee: args?['employee']), // No need to pass employee explicitly
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page Not Found')),
          ),
        );
    }
  }
}
