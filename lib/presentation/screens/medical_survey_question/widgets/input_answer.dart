import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class InputAnswer extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const InputAnswer({
    Key? key,
    required this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      style: AppTextStyle.bodyXSmall,
      decoration: InputDecoration(
        hintText: 'Free description',
        hintStyle: AppTextStyle.darkGrayBodyXSmall,
        enabled: enabled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0.5,
            color: AppColors.lightGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0.5,
            color: AppColors.yellow,
          ),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      maxLines: 4,
    );
  }
}
