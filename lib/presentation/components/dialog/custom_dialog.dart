import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class DialogActionButton {
  final VoidCallback onTap;
  final String title;
  DialogActionButton({
    required this.onTap,
    required this.title,
  });
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String? content;
  final List<Widget>? body;
  final String? icon;
  final List<DialogActionButton> actions;
  final bool hasTextField;
  final String hintTextField;
  final TextEditingController? textEditingController;
  const CustomDialog({
    super.key,
    required this.title,
    this.content,
    this.body,
    this.icon,
    required this.actions,
    this.hasTextField = false,
    this.textEditingController,
    this.hintTextField = '',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 36,
                offset: const Offset(0, 8),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) _buildIcon(),
              _buildTitleAndContent(),
              _buildHorizontalDivider(),
              _buildActonButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff2093FC), Color(0xff2372D9)], // red to
        ),
      ),
      child: Image.asset(icon ?? ''),
    );
  }

  Widget _buildTitleAndContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.headingSmall),
          const SizedBox(height: 16),
          if ((content ?? '').isNotEmpty)
            Text(content ?? '', style: AppTextStyle.bodyMedium),
          if (body != null) ...body ?? [],
        ],
      ),
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: AppColors.lightGray,
    );
  }

  Widget _buildActonButtons() {
    return SizedBox(
      height: 56,
      child: Row(
        children: List<Widget>.generate(actions.length, (index) {
          final dialogActionButton = actions[index];
          if (index == 0) {
            return _buildActionButton(
              dialogActionButton: dialogActionButton,
              hasDivider: false,
            );
          }
          return _buildActionButton(
            dialogActionButton: dialogActionButton,
            hasDivider: true,
          );
        }),
      ),
    );
  }

  Widget _buildActionButton({
    required DialogActionButton dialogActionButton,
    required bool hasDivider,
  }) {
    return Expanded(
      child: Row(
        children: [
          if (hasDivider)
            Container(
              width: 0.5,
              height: double.infinity,
              color: AppColors.lightGray,
            ),
          Expanded(
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: dialogActionButton.onTap,
                child: Center(
                  child: Text(
                    dialogActionButton.title,
                    style: AppTextStyle.cyanLabelMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
