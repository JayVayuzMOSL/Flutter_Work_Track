import 'package:flutter/material.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/extensions.dart';
import 'package:flutter_work_track/presentation/widgets/date_dialog_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePicker extends StatelessWidget {
  final String selectedDate;
  final Function(String) onDateChanged;
  final String hintText;

  CustomDatePicker({
    required this.selectedDate,
    required this.onDateChanged,
    required this.hintText,
    super.key,
  });

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          datePickerDialog(context, pageController, selectedDate, (value){
            onDateChanged(value);
          });
        },
        child: InputDecorator(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today, color: AppColors.primaryBlue, size: 20.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.green, width: 2.w),
            ),
          ),
          child: Text(
            formatDate(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textAccentColor),
          ),
        ),
      ),
    );
  }

  formatDate(){
    DateTime now = DateTime.now();
    if(selectedDate.isNotEmpty){
      DateTime initialDate = selectedDate.toDate();
      return initialDate.year == now.year &&
          initialDate.month == now.month &&
          initialDate.day == now.day
          ? "Today"
          : selectedDate.toString();
    }
    return hintText;
  }
}