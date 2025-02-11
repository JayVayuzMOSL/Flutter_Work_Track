import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_constants.dart';
import 'package:flutter_work_track/core/constants/app_images.dart';
import 'package:flutter_work_track/core/constants/app_strings.dart';
import 'package:flutter_work_track/core/constants/extensions.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/presentation/cubit/employee_cubit.dart';
import 'package:flutter_work_track/presentation/cubit/employee_state.dart';
import 'package:flutter_work_track/presentation/widgets/employee_card.dart';
import 'package:flutter_work_track/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.employeeListTitle,
          style: GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        leading: Container(),
        leadingWidth: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.addEditEmployee);
          context.read<EmployeeCubit>().loadEmployees(); // Refresh list after returning
        },
        backgroundColor: AppColors.primaryBlue,
        child: Icon(Icons.add, color: AppColors.whiteTextColor, size: 24.sp),
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        bloc: context.watch<EmployeeCubit>()..loadEmployees(),
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Center(
                child: SizedBox(width: 30.w, height: 30.h, child: CircularProgressIndicator()));
          } else if (state is EmployeeLoaded) {
            List<EmployeeModel> employees = state.employees;

            DateTime currentDate = DateTime.now();
            currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

            List<EmployeeModel> currentEmployees = employees
                .where((e) =>
                    e.dateOfLeaveCompany.isEmpty ||
                    e.dateOfLeaveCompany.toDate().isAfter(currentDate) ||
                    e.dateOfLeaveCompany.toDate().isAtSameMomentAs(currentDate))
                .toList();

            List<EmployeeModel> previousEmployees = employees
                .where((e) =>
                    e.dateOfLeaveCompany.isNotEmpty &&
                    e.dateOfLeaveCompany.toDate().isBefore(currentDate))
                .toList();

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      if (currentEmployees.isNotEmpty)
                        _buildSectionTitle(context, AppStrings.currentEmployTitle),
                      if (currentEmployees.isNotEmpty)
                        _buildEmployeeList(context, currentEmployees, isEmployed: true),
                      if (previousEmployees.isNotEmpty)
                        _buildSectionTitle(context, AppStrings.previousEmployTitle),
                      if (previousEmployees.isNotEmpty)
                        _buildEmployeeList(context, previousEmployees),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade300,
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    AppStrings.swipeLeftDeleteTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.greyTextAccentColor),
                  ),
                )
              ],
            );
          } else {
            return Center(
                child: Image.asset(AppImages.noDataFoundIcon, width: 100.w, height: 100.h));
          }
        },
      ),
    );
  }

  Widget _buildEmployeeList(BuildContext context, List<EmployeeModel> employees,
      {bool isEmployed = false}) {
    final cubit = context.read<EmployeeCubit>();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return EmployeeCard(
          employee: employee,
          isEmployed: isEmployed,
          onEdit: () async {
            await Navigator.pushNamed(
              context,
              AppRoutes.addEditEmployee,
              arguments: {"employee": employee},
            );
            cubit.loadEmployees(); // Refresh list
          },
          onDelete: () {
            cubit.deleteEmployee(employee.id);
            showSnackBar(
              AppStrings.empDeletedSuccessTitle,
              snackbarAction: SnackBarAction(
                label: AppStrings.undoTitle,
                onPressed: () {
                  cubit.addEmployee(employee, undoItem: true);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: Colors.grey.shade300,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primaryBlue),
      ),
    );
  }
}
