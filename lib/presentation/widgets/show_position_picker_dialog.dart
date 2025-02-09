import 'package:flutter/material.dart';
import 'package:flutter_work_track/core/constants/app_colors.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.whiteTextColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: positions.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) => ListTile(
          title: Center(
            child: Text(
              positions[index],
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.textAccentColor),
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