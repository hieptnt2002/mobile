import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class CalendarChevronButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDisable;
  const CalendarChevronButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isDisable,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: AppColors.lightGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: AppColors.darkGray,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        child: Icon(
          icon,
          size: 16,
          color: isDisable ? AppColors.darkGray : AppColors.blue,
        ),
      ),
    );
  }
}
