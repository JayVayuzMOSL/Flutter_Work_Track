import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';
import 'package:flutter_work_track/core/constants/app_styles.dart';

final List<String> positions = [
  "Product Designer",
  "Flutter Developer",
  "QA Tester",
  "Product Owner"
];

void showPositionPicker(BuildContext context, Function(String) tapCallBack) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteTextColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: positions.length,
        separatorBuilder: (_, __) => Divider(thickness: 1.h),
        itemBuilder: (_, index) => ListTile(
          title: Center(
            child: Text(
              positions[index],
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.textAccentColor, fontSize: spRes(16)),
            ),
          ),
          onTap: () {
            tapCallBack(positions[index]);
          },
        ),
      ),
    ),
  );
}
