import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class CommonOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final IconData? iconData;
  final Color color;
  const CommonOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.iconData,
    this.color = AppColors.cyan,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColors.cyan;
          }
          return Colors.white;
        }),
        fixedSize: const MaterialStatePropertyAll(Size(double.infinity, 40)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        side: MaterialStatePropertyAll(BorderSide(width: 2, color: color)),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Colors.cyan;
          },
        ),
        textStyle:
            const MaterialStatePropertyAll(AppTextStyle.whiteLabelMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(title),
          ),
          if (iconData != null) Icon(iconData, size: 20, color: Colors.cyan),
        ],
      ),
    );
  }
}
