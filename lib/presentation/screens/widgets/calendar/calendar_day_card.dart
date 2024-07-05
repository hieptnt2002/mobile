import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

enum DateStatus { available, notAvailable }

class CalendarDayCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final DateStatus dateStatus;
  final VoidCallback? onTap;

  const CalendarDayCard({
    super.key,
    required this.date,
    required this.isSelected,
    required this.dateStatus,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            color: _getDayItemBackgroundColor(dateStatus, date),
            borderRadius: BorderRadius.circular(4),
            border: isSelected
                ? null
                : Border.all(
                    width: 1,
                    color: _getDayItemBorderColor(dateStatus),
                  ),
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style: _getDayItemTextStyle(date),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _getDayItemTextStyle(DateTime date) {
    return isSelected
        ? AppTextStyle.whiteLabelMedium
        : AppTextStyle.labelMedium;
  }

  Color _getDayItemBackgroundColor(DateStatus dateStatus, DateTime date) {
    if (isSelected) return AppColors.blue;
    if (dateStatus == DateStatus.available) return AppColors.aliceBlue;
    if (dateStatus == DateStatus.notAvailable) return AppColors.lightGray;
    return Colors.transparent;
  }

  Color _getDayItemBorderColor(DateStatus dateStatus) {
    switch (dateStatus) {
      case DateStatus.available:
        return AppColors.green;
      case DateStatus.notAvailable:
        return AppColors.lightGray;
    }
  }
}
