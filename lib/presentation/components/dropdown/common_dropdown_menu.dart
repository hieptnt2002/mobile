import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class CommonDropdownMenuItemData<T> {
  T? value;
  final String text;

  CommonDropdownMenuItemData({
    this.value,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      other is CommonDropdownMenuItemData &&
      other.runtimeType == runtimeType &&
      other.value == value &&
      other.text == text;

  @override
  int get hashCode => value.hashCode;
}

class CommonDropdownMenu<T> extends StatefulWidget {
  final CommonDropdownMenuItemData<T>? initialValue;
  final List<CommonDropdownMenuItemData<T>> values;
  final double? width;
  final bool disable;
  final bool required;
  final String hintText;
  final void Function(T?)? onChanged;
  final String? Function(CommonDropdownMenuItemData<T>?)? validator;

  const CommonDropdownMenu({
    super.key,
    this.initialValue,
    required this.values,
    this.onChanged,
    this.width,
    this.disable = false,
    this.hintText = '',
    this.required = true,
    this.validator,
  });

  @override
  State<CommonDropdownMenu<T>> createState() => _CommonDropdownMenuState<T>();
}

class _CommonDropdownMenuState<T> extends State<CommonDropdownMenu<T>> {
  late var selectedValue = widget.initialValue;
  final enableOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: AppColors.lightGray, width: 1),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: DropdownButtonFormField<CommonDropdownMenuItemData<T>?>(
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: widget.disable ? AppColors.lightGray : null,
          filled: widget.disable ? true : false,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 42,
        isExpanded: true,
        style: AppTextStyle.bodyMedium,
        borderRadius: BorderRadius.circular(4),
        value: selectedValue,
        items: [
          if (widget.values.isEmpty && widget.initialValue == null)
            const DropdownMenuItem(value: null, child: Text('Please select')),
          ...widget.values.map(
            (e) => DropdownMenuItem(value: e, child: Text(e.text)),
          ),
        ],
        onChanged: widget.disable
            ? null
            : (value) {
                setState(() {
                  selectedValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value?.value);
                }
              },
        validator: widget.required && widget.validator == null
            ? (value) {
                if (value == null) {
                  return 'Required';
                }
                return null;
              }
            : widget.validator,
      ),
    );
  }
}
