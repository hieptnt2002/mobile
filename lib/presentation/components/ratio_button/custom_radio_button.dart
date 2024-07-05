import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final void Function(T)? onChanged;
  final Color color;
  final Color borderColor;
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.color = AppColors.cyan,
    this.borderColor = AppColors.lightGray,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value == groupValue ? color : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
