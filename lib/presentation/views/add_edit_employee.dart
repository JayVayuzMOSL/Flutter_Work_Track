import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_constants.dart';
import 'package:flutter_work_track/core/constants/app_images.dart';
import 'package:flutter_work_track/core/constants/app_strings.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/presentation/cubit/add_edit_employee_state.dart';
import 'package:flutter_work_track/presentation/cubit/employee_cubit.dart';
import 'package:flutter_work_track/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:flutter_work_track/presentation/widgets/custom_date_picker.dart';
import 'package:flutter_work_track/presentation/widgets/show_position_picker_dialog.dart';
import 'package:flutter_work_track/routes/app_routes.dart';
import 'package:flutter_work_track/service_locator.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  final EmployeeModel? employee;

  const AddEditEmployeeScreen({this.employee, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee == null ? AppStrings.addEmployeeDetails : AppStrings.editEmployeeDetails),
        actions: employee == null
            ? null
            : [
          IconButton(
            onPressed: () => _deleteEmployee(context),
            icon: Image.asset(AppImages.deleteIcon, color: AppColors.whiteTextColor),
          ),
        ],
      ),
      body: BlocBuilder<AddEditEmployeeCubit, AddEditEmployeeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(context, state.name),
                const SizedBox(height: 16),
                _buildPositionPicker(context, state.position),
                const SizedBox(height: 16),
                _buildDatePickers(context, state.startDate, state.endDate),
                const Spacer(),
                _buildFooterButtons(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String name) {
    return TextFormField(
      initialValue: name,
      onChanged: (value) => context.read<AddEditEmployeeCubit>().updateName(value),
      decoration: InputDecoration(
        hintText: AppStrings.employeeName,
        prefixIcon: const Icon(Icons.person_outline, color: AppColors.primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Widget _buildPositionPicker(BuildContext context, String? selectedPosition) {
    return GestureDetector(
      onTap: () {
        showPositionPicker(context, (value) {
          context.read<AddEditEmployeeCubit>().updatePosition(value);
          Navigator.pop(context);
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: AppStrings.positionTitle,
          prefixIcon: const Icon(Icons.work_outline, color: AppColors.primaryBlue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedPosition ?? AppStrings.selectPositionTitle),
            Image.asset(AppImages.dropdownIcon, color: AppColors.primaryBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickers(BuildContext context, String? startDate, String? endDate) {
    return Row(
      children: [
        CustomDatePicker(
          selectedDate: startDate ?? '',
          onDateChanged: (date) => context.read<AddEditEmployeeCubit>().updateStartDate(date),
          hintText: AppStrings.noDateTitle,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.arrow_right_alt_outlined, color: AppColors.primaryBlue, size: 20),
        ),
        CustomDatePicker(
          selectedDate: endDate ?? '',
          onDateChanged: (date) => context.read<AddEditEmployeeCubit>().updateEndDate(date),
          hintText: AppStrings.noDateTitle,
        ),
      ],
    );
  }

  Widget _buildFooterButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildButton(AppStrings.cancelCTATitle, AppColors.greyCTACancelColor, AppColors.primaryBlue, () {
              Navigator.of(context).pop();
            }),
            const SizedBox(width: 10),
            _buildButton(AppStrings.saveCTATitle, AppColors.primaryBlue, AppColors.whiteTextColor, () {
              _saveEmployee(context);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }

  void _saveEmployee(BuildContext context) {
    final cubit = context.read<AddEditEmployeeCubit>();
    final state = cubit.state;

    if (state.name.isEmpty || state.position == null || state.startDate == null || state.endDate == null) {
      showSnackBar(AppStrings.pleaseFillFieldsError);
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
      getIt<EmployeeCubit>().updateEmployee(newEmployee);
      showSnackBar(AppStrings.employeeUpdatedSuccess);
    }else{
      getIt<EmployeeCubit>().addEmployee(newEmployee);
      showSnackBar(AppStrings.employeeAddedSuccess);
    }

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _deleteEmployee(BuildContext context) {
    getIt<EmployeeCubit>().deleteEmployee(employee!.id);
    showSnackBar(AppStrings.empDeletedSuccessTitle,snackbarAction: SnackBarAction(
      label: AppStrings.undoTitle,
      onPressed: () {
        getIt<EmployeeCubit>().addEmployee(employee!,undoItem: true);
      },
    ));
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }
}
