import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_strings.dart';

Future<void> datePickerDialog(BuildContext context, PageController pageController,
    String? selectedDate, Function(String) onDaySelected) async {
  DateTime now = DateTime.now();
  String? selectedDateValue = selectedDate!.isNotEmpty?selectedDate:DateFormat('d MMM yyyy').format(now);
  DateTime focusedDayValue =
      DateFormat('d MMM yyyy').parse(selectedDateValue);

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // **Preset Date Buttons**
                  Row(
                    children: [
                      _buildPresetButton(
                          context,
                          focusedDayValue, AppStrings.today, now, (date) {
                        setState(() {
                          focusedDayValue = date;
                        });
                      }),
                      const SizedBox(width: 8),
                      _buildPresetButton(
                        context,
                          focusedDayValue, AppStrings.nextMonday, _getNextWeekday(now, DateTime.monday),
                          (date) {
                        setState(() {
                          focusedDayValue = date;
                        });
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      _buildPresetButton(
                        context,
                          focusedDayValue, AppStrings.nextTuesday, _getNextWeekday(now, DateTime.tuesday),
                          (date) {
                        setState(() {
                          focusedDayValue = date;
                        });
                      }),
                      SizedBox(width: 8),
                      _buildPresetButton(
                        context,
                          focusedDayValue, AppStrings.afterOneWeek, now.add(Duration(days: 7)), (date) {
                        setState(() {
                          focusedDayValue = date;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // **Calendar Widget**
                  TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: focusedDayValue,
                    headerVisible: true,
                    headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                    currentDay: focusedDayValue,
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      focusedDayValue = focusedDay;
                      selectedDateValue = DateFormat("d MMM yyyy").format(focusedDay);
                      setState(() {});
                    },
                    onCalendarCreated: (controller) => pageController = controller,
                    onPageChanged: (focusedDay) {
                      focusedDayValue = focusedDay;
                      selectedDateValue = DateFormat("d MMM yyyy").format(focusedDay);
                      setState(() {});
                    },
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primaryBlue, // Change this to your desired color
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: AppColors.primaryBlue, // Customize today's date color
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),

                  // **Selected Date & Action Buttons**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: AppColors.primaryBlue),
                          const SizedBox(width: 8),
                          Text(selectedDateValue ?? '', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textAccentColor)),
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
                          const SizedBox(width: 10),
                          _buildButton(
                              context, AppStrings.saveCTATitle, AppColors.primaryBlue, AppColors.whiteTextColor,
                              () {
                            onDaySelected(selectedDateValue!);
                            Navigator.of(context).pop();
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

// **Build Preset Date Button**
Widget _buildPresetButton(
    BuildContext context,
    DateTime? initialDate, String label, DateTime date, Function(dynamic) callback) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: initialDate!.day == date.day ? AppColors.primaryBlue : AppColors.whiteTextColor,
        foregroundColor: initialDate.day == date.day ? AppColors.whiteTextColor : AppColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        callback(date);
      },
      child: Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color:  initialDate.day == date.day ? AppColors.whiteTextColor : AppColors.primaryBlue,
      )),
    ),
  );
}

// **Get Next Specific Weekday**
DateTime _getNextWeekday(DateTime date, int weekday) {
  int daysToAdd = (weekday - date.weekday + 7) % 7;
  return date.add(Duration(days: daysToAdd == 0 ? 7 : daysToAdd));
}

// **Build Generic Button**
Widget _buildButton(
    BuildContext context, String text, Color color, Color textColor, VoidCallback onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    minWidth: 60,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child:
          Text(text, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: textColor)),
    ),
  );
}
