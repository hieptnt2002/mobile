import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/button/common_outline_button.dart';
import 'package:make_appointment_app/presentation/components/button/common_small_button.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class SelectCancellationReasonDialog extends StatefulWidget {
  const SelectCancellationReasonDialog({super.key});

  @override
  State<SelectCancellationReasonDialog> createState() =>
      _SelectCancellationReasonDialogState();
}

class _SelectCancellationReasonDialogState
    extends State<SelectCancellationReasonDialog> {
  late final TextEditingController _textController;

  late final ScrollController _scrollController;
  bool _isShowError = false;

  late final List<String> _reasons = context.t.treatment.listReason.split(', ');
  final List<String> _selectedReasons = [];
  @override
  void initState() {
    _textController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              context.t.treatment.selectCancellationReason,
              style: AppTextStyle.headingXSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildReasonSelectionList(),
            ),
            if (_isShowError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  context.t.treatment.pleaseSelectReasons,
                  style: AppTextStyle.redBodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CommonOutlinedButton(
                title: context.t.treatment.close,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: AppColors.lightGray,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CommonSmallButton(
                title: context.t.treatment.confirm,
                onPressed: () {
                  _handleConfirmButton();
                },
                buttonType: ButtonType.info,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReasonSelectionList() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.t.treatment.pleaseSelectReasonFromOptionBelow,
              style: AppTextStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          ..._reasons.map(
            (reason) {
              return _buildReasonItem(reason);
            },
          ),
          const SizedBox(height: 12),
          _buildReasonTextField(),
        ],
      ),
    );
  }

  Widget _buildReasonItem(String reason) {
    bool isSelected = _selectedReasons.contains(reason);
    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      value: isSelected,
      onChanged: (bool? value) {
        setState(() {
          if (value ?? false) {
            _selectedReasons.add(reason);
          } else {
            _selectedReasons.remove(reason);
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      title: Text(
        reason,
        style: isSelected
            ? AppTextStyle.w700TextColor16Px
            : AppTextStyle.bodyMedium,
      ),
      activeColor: AppColors.cyan,
    );
  }

  Widget _buildReasonTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: context.t.treatment.hintTextReason,
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
        onTap: _scrollToEnd,
        onChanged: (value) {
          _scrollToEnd();
        },
      ),
    );
  }

  void _scrollToEnd() {
    setState(() {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _handleConfirmButton() {
    String additionalReason = _textController.text;
    if (additionalReason.trim().isNotEmpty) {
      _selectedReasons.add(additionalReason);
    }
    if (_selectedReasons.isNotEmpty) {
      _isShowError = false;
      Navigator.pop(context, _selectedReasons);
    } else {
      setState(() {
        _isShowError = true;
      });
    }
  }
}
