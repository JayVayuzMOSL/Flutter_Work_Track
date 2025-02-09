import 'package:flutter/material.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/presentation/widgets/date_dialog_widget.dart';
import 'package:intl/intl.dart';

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
            prefixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryBlue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.green, width: 2.0),
            ),
          ),
          child: Text(
            formatDate(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  formatDate(){
    DateTime now = DateTime.now();
    if(selectedDate.isNotEmpty){
      DateTime initialDate = selectedDate.isNotEmpty?DateFormat('d MMM yyyy').parse(selectedDate.toString()):now;
      return initialDate.year == now.year &&
          initialDate.month == now.month &&
          initialDate.day == now.day
          ? "Today"
          : selectedDate.toString();
    }
    return hintText;
  }
}