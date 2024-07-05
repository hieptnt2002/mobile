import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

enum ButtonType { primary, secondary, warning, info }

class CommonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final ButtonType buttonType;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.buttonType,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: const Size(double.maxFinite, 62.0),
        backgroundColor: _getBackgroundColorButton(type: buttonType),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: leadingIcon,
                  ),
                Text(
                  title,
                  style: _getColorTextButton(type: buttonType),
                ),
              ],
            ),
          ),
          if (trailingIcon != null) trailingIcon!,
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

  static TextStyle? _getColorTextButton({required ButtonType type}) {
    switch (type) {
      case ButtonType.warning:
        return AppTextStyle.blackHeadingXXSmall;
      default:
        return AppTextStyle.whiteHeadingXSmall;
    }
  }
}
