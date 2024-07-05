import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String Function(String?)? validator;
  final bool enabled;
  final bool required;
  const CommonTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    final enableOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: AppColors.lightGray, width: 1),
    );
    return TextFormField(
      controller: controller,
      enabled: enabled,
      cursorColor: Colors.black,
      validator: required && validator == null
          ? (value) {
              if ((value ?? '').trim().isEmpty) {
                return 'Required';
              }
              return null;
            }
          : validator,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: enabled ? null : AppColors.lightGray,
        filled: enabled ? null : true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: enableOutlineBorder,
        enabledBorder: enableOutlineBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.yellow, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.red, width: 1),
        ),
        disabledBorder: enableOutlineBorder,
      ),
    );
  }
}
