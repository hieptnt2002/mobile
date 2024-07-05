import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class CommonSmallButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final ButtonType buttonType;
  final Widget? leadingIcon;

  const CommonSmallButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.buttonType,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fixedSize: const Size(double.infinity, 40),
        backgroundColor: _getBackgroundColorButton(type: buttonType),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: leadingIcon,
            ),
          Text(title, style: AppTextStyle.whiteLabelMedium),
        ],
      ),
    );
  }

  static Color _getBackgroundColorButton({required ButtonType type}) {
    switch (type) {
      case ButtonType.primary:
        return AppColors.blue;
      case ButtonType.secondary:
        return AppColors.green;
      case ButtonType.warning:
        return AppColors.yellow;
      case ButtonType.info:
        return AppColors.cyan;
    }
  }
}
