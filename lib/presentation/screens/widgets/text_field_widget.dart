import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  final double? width;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? emailAddress;
  final bool? obscureText;
  final TextEditingController? passwordEditingController;
  final String? name;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText,
    this.emailAddress,
    this.passwordEditingController,
    this.name,
    this.width,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final multiLanguage = context.t.TextFieldWidget;
    final regexEmail = RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]');
    final regexPassword = RegExp(r'^.{8,}$');
    return SizedBox(
      width: widget.width,
      child: Theme(
        data: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            outline: AppColors.gray,
            primary: AppColors.blue,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            style: const TextStyle(
              fontSize: 13,
            ),
            cursorColor: Colors.blue[900],
            controller: widget.controller,
            obscureText: widget.obscureText ?? false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(borderSide: BorderSide()),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.all(8),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return '${multiLanguage.emptyMessage} ${widget.name}';
              } else if (widget.emailAddress == TextInputType.emailAddress &&
                  !regexEmail.hasMatch(value)) {
                return multiLanguage.invalidEmailMessage;
              } else if (widget.name == multiLanguage.conditionPassword ||
                  widget.name == multiLanguage.conditionConfirmPassword) {
                if (!regexPassword.hasMatch(value)) {
                  return multiLanguage.requiredQuantityCharacterMessage;
                } else if (widget.passwordEditingController?.text == null) {
                  return null;
                } else if (widget.passwordEditingController?.text != value) {
                  return multiLanguage.checkTheSamePasswordMessage;
                }
              } else {
                return null;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
