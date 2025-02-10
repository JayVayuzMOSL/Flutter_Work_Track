import 'package:flutter/material.dart';
import 'package:flutter_work_track/core/constants/extensions.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_strings.dart';

Future<void> datePickerDialog(BuildContext context, PageController pageController,
    String? selectedDate, Function(String) onDaySelected) async {
  DateTime now = DateTime.now();
  ValueNotifier<DateTime> focusedDayNotifier = ValueNotifier(
      selectedDate!.isNotEmpty ? selectedDate.toDate() : now);

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<DateTime>(
                valueListenable: focusedDayNotifier,
                builder: (context, focusedDayValue, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          _buildPresetButton(
                              context,
                              focusedDayValue,
                              AppStrings.today,
                              now,
                                  (date) {
                                focusedDayNotifier.value = date;
                              }),
                          SizedBox(width: 8.w),
                          _buildPresetButton(
                            context,
                            focusedDayValue,
                            AppStrings.nextMonday,
                            _getNextWeekday(now, DateTime.monday),
                                (date) {
                              focusedDayNotifier.value = date;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _buildPresetButton(
                              context, focusedDayValue, AppStrings.nextTuesday,
                              _getNextWeekday(now, DateTime.tuesday), (date) {
                            focusedDayNotifier.value = date;
                          }),
                          SizedBox(width: 8.w),
                          _buildPresetButton(
                              context, focusedDayValue, AppStrings.afterOneWeek,
                              now.add(const Duration(days: 7)), (date) {
                            focusedDayNotifier.value = date;
                          }),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      TableCalendar(
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        focusedDay: focusedDayValue,
                        headerVisible: true,
                        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                        currentDay: focusedDayValue,
                        calendarFormat: CalendarFormat.month,
                        onDaySelected: (selectedDay, focusedDay) {
                          focusedDayNotifier.value = focusedDay;
                        },
                        onCalendarCreated: (controller) => pageController = controller,
                        onPageChanged: (focusedDay) {
                          focusedDayNotifier.value = focusedDay;
                        },
                        calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Divider(thickness: 1.h),
              ValueListenableBuilder<DateTime>(
                valueListenable: focusedDayNotifier,
                builder: (context, selectedDateValue, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: AppColors.primaryBlue, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            selectedDateValue.toDateString(),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textAccentColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildButton(
                              context,
                              AppStrings.cancelCTATitle,
                              AppColors.greyCTACancelColor,
                              AppColors.primaryBlue,
                                  () => Navigator.of(context).pop()),
                          SizedBox(width: 10.w),
                          _buildButton(
                              context,
                              AppStrings.saveCTATitle,
                              AppColors.primaryBlue,
                              AppColors.whiteTextColor,
                                  () {
                                onDaySelected(selectedDateValue.toDateString());
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildPresetButton(
    BuildContext context, DateTime? initialDate, String label, DateTime date, Function(dynamic) callback) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: currentIsSameDay(initialDate, date)
            ? AppColors.primaryBlue
            : AppColors.whiteTextColor,
        foregroundColor: currentIsSameDay(initialDate, date)
            ? AppColors.whiteTextColor
            : AppColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      onPressed: () {
        callback(date);
      },
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: currentIsSameDay(initialDate, date)
              ? AppColors.whiteTextColor
              : AppColors.primaryBlue,
          fontSize: 13.sp,
        ),
      ),
    ),
  );
}

bool currentIsSameDay(DateTime? initialDate, DateTime date) =>
    initialDate!.year == date.year &&
        initialDate.month == date.month &&
        initialDate.day == date.day;

DateTime _getNextWeekday(DateTime date, int weekday) {
  int daysToAdd = (weekday - date.weekday + 7) % 7;
  return date.add(Duration(days: daysToAdd == 0 ? 7 : daysToAdd));
}

Widget _buildButton(
    BuildContext context, String text, Color color, Color textColor, VoidCallback onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
    minWidth: 60.w,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: textColor,
          fontSize: 14.sp,
        ),
      ),
    ),
  );
}
