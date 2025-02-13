import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_images.dart';
import 'package:flutter_work_track/core/constants/app_styles.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/routes/app_routes.dart';

class EmployeeCard extends StatefulWidget {
  final EmployeeModel employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isEmployed;

  const EmployeeCard({
    required this.employee,
    required this.onEdit,
    required this.onDelete,
    required this.isEmployed,
    super.key,
  });

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  bool isDismissed = false;

  @override
  Widget build(BuildContext context) {
    if (isDismissed) return SizedBox.shrink();
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.addEditEmployee,
              arguments: {"employee": widget.employee});
        },
        child: Dismissible(
          key: ValueKey(widget.employee.id),
          direction: DismissDirection.endToStart,
          // Swipe from right to left
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: wRes(20)),
            alignment: Alignment.centerRight,
            color: AppColors.redBackgroundColor, // Background color when swiped
            child: Image.asset(
              AppImages.deleteIcon,
              color: AppColors.whiteTextColor,
              width: wRes(24),
              height: hRes(24),
            ),
          ),
          onDismissed: (direction) {
            setState(() => isDismissed = true);
            widget.onDelete(); // Remove employee from list
          },
          child: Padding(
            padding: EdgeInsets.all(wRes(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.employee.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textAccentColor,
                        fontSize: spRes(16),
                      ),
                ),
                SizedBox(height: hRes(4)),
                Text(
                  widget.employee.position,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.greyTextAccentColor,
                        fontSize: spRes(14),
                      ),
                ),
                SizedBox(height: hRes(4)),
                Text(
                  widget.isEmployed
                      ? 'From ${widget.employee.dateOfJoining}'
                      : '${widget.employee.dateOfJoining} - ${widget.employee.dateOfLeaveCompany}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.greyTextAccentColor,
                        fontSize: spRes(12),
                      ),
                ),
              ],
            ),
          ),
        ));
  }
}
