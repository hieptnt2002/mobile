import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

// ignore: must_be_immutable
class SaveEmailPassWidget extends StatefulWidget {
  late bool? isCheckbox;
  final String title;

  SaveEmailPassWidget({
    super.key,
    required this.isCheckbox,
    required this.title,
  });

  @override
  State<SaveEmailPassWidget> createState() => _SaveEmailPassWidgetState();
}

class _SaveEmailPassWidgetState extends State<SaveEmailPassWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          width: 19,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Container(
            height: 19,
            color: Colors.white,
            child: Checkbox(
              activeColor: Colors.blue[900],
              value: widget.isCheckbox,
              onChanged: (val) {
                widget.isCheckbox = val!;
                setState(() {});
              },
              side: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        Text(
          widget.title,
          style: AppTextStyle.bodyXSmall,
        ),
      ],
    );
  }
}
