import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_constants.dart';
import 'package:flutter_work_track/core/constants/app_images.dart';
import 'package:flutter_work_track/core/constants/app_strings.dart';
import 'package:flutter_work_track/core/constants/extensions.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/presentation/cubit/add_edit_employee_state.dart';
import 'package:flutter_work_track/presentation/cubit/employee_cubit.dart';
import 'package:flutter_work_track/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:flutter_work_track/presentation/widgets/custom_date_picker.dart';
import 'package:flutter_work_track/presentation/widgets/show_position_picker_dialog.dart';
import 'package:flutter_work_track/routes/app_routes.dart';
import 'package:intl/intl.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  final EmployeeModel? employee;

  const AddEditEmployeeScreen({this.employee, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addEditEmployeeCubit = context.read<AddEditEmployeeCubit>();
    final employeeCubit = context.read<EmployeeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          employee == null ? AppStrings.addEmployeeDetails : AppStrings.editEmployeeDetails,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteTextColor),
        ),
        actions: employee == null
            ? null
            : [
          IconButton(
            onPressed: () => _deleteEmployee(context, employeeCubit),
            icon: Image.asset(
              AppImages.deleteIcon,
              color: AppColors.whiteTextColor,
              width: 24.w,
            ),
          ),
        ],
      ),
      body: BlocBuilder<AddEditEmployeeCubit, AddEditEmployeeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(state.name, addEditEmployeeCubit),
                SizedBox(height: 16.h),
                _buildPositionPicker(context, state.position, addEditEmployeeCubit),
                SizedBox(height: 16.h),
                _buildDatePickers(state.startDate, state.endDate, addEditEmployeeCubit),
                const Spacer(),
                _buildFooterButtons(context, addEditEmployeeCubit, employeeCubit),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String name, AddEditEmployeeCubit cubit) {
    return TextFormField(
      initialValue: name,
      onChanged: (value) => cubit.updateName(value),
      decoration: InputDecoration(
        hintText: AppStrings.employeeName,
        prefixIcon: Icon(Icons.person_outline, color: AppColors.primaryBlue, size: 24.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  Widget _buildPositionPicker(BuildContext context, String? selectedPosition, AddEditEmployeeCubit cubit) {
    return GestureDetector(
      onTap: () {
        showPositionPicker(context, (value) {
          cubit.updatePosition(value);
          Navigator.pop(context);
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: AppStrings.positionTitle,
          prefixIcon: Icon(Icons.work_outline, color: AppColors.primaryBlue, size: 24.w),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedPosition ?? AppStrings.selectPositionTitle, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textAccentColor)),
            Image.asset(AppImages.dropdownIcon, color: AppColors.primaryBlue, width: 24.w),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickers(String? startDate, String? endDate, AddEditEmployeeCubit cubit) {
    return Row(
      children: [
        CustomDatePicker(
          selectedDate: startDate ?? '',
          onDateChanged: (date) => cubit.updateStartDate(date),
          hintText: AppStrings.noDateTitle,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Icon(Icons.arrow_right_alt_outlined, color: AppColors.primaryBlue, size: 20.w),
        ),
        CustomDatePicker(
          selectedDate: endDate ?? '',
          onDateChanged: (date) => cubit.updateEndDate(date),
          hintText: AppStrings.noDateTitle,
        ),
      ],
    );
  }

  Widget _buildFooterButtons(BuildContext context, AddEditEmployeeCubit cubit, EmployeeCubit employeeCubit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildButton(context, AppStrings.cancelCTATitle, AppColors.greyCTACancelColor, AppColors.primaryBlue, () {
              Navigator.of(context).pop();
            }),
            SizedBox(width: 10.w),
            _buildButton(context, AppStrings.saveCTATitle, AppColors.primaryBlue, AppColors.whiteTextColor, () {
              _saveEmployee(context, cubit, employeeCubit);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Text(text, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: textColor)),
      ),
    );
  }

  void _saveEmployee(BuildContext context, AddEditEmployeeCubit cubit, EmployeeCubit employeeCubit) {
    final state = cubit.state;

    if (state.name.isEmpty || state.position == null || state.startDate == null || state.endDate == null) {
      showSnackBar(AppStrings.pleaseFillFieldsError);
      return;
    }
    if(state.startDate == state.endDate){
      showSnackBar(AppStrings.startEndDateError);
      return;
    }
    if(state.startDate!.toDate().isAfter(state.endDate!.toDate())){
      showSnackBar(AppStrings.startBeforeDate);
      return;
    }

    final newEmployee = EmployeeModel(
      id: employee?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: state.name,
      position: state.position!,
      dateOfJoining: state.startDate!,
      dateOfLeaveCompany: state.endDate!,
    );

    if(employee!=null){
      employeeCubit.updateEmployee(newEmployee);
      showSnackBar(AppStrings.employeeUpdatedSuccess);
    }else{
      employeeCubit.addEmployee(newEmployee);
      showSnackBar(AppStrings.employeeAddedSuccess);
    }

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _deleteEmployee(BuildContext context, EmployeeCubit employeeCubit,) {
    employeeCubit.deleteEmployee(employee!.id);
    showSnackBar(AppStrings.empDeletedSuccessTitle,snackbarAction: SnackBarAction(
      label: AppStrings.undoTitle,
      onPressed: () {
        employeeCubit.addEmployee(employee!,undoItem: true);
      },
    ));
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }
}
