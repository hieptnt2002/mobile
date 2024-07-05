import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/button/common_outline_button.dart';
import 'package:make_appointment_app/presentation/components/button/common_small_button.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_details/dialog/cancellation_reason_view_model.dart';

class ConfirmCancellationReasonDialog extends StatefulWidget {
  final Appointment appointment;
  final List<String> reasons;
  const ConfirmCancellationReasonDialog({
    Key? key,
    required this.appointment,
    required this.reasons,
  }) : super(key: key);

  @override
  State<ConfirmCancellationReasonDialog> createState() =>
      _ConfirmCancellationReasonDialogState();
}

class _ConfirmCancellationReasonDialogState
    extends State<ConfirmCancellationReasonDialog> {
  late final CancellationReasonViewModel _viewModel =
      context.read<CancellationReasonViewModel>();
  List<String> get _reasons => widget.reasons;
  Appointment get _appointment => widget.appointment;

  void _showSnackBar({required String title, bool isSuccess = true}) {
    Utils.showSnackbar(title, isSuccess);
  }

  void _handleCancelAppointment() {
    _viewModel.cancelAppointmentById(
      appointmentId: _appointment.id,
      cancelReasons: _reasons.join(', '),
      onSuccess: (data) {
        Future.delayed(
          Duration.zero,
          () {
            Navigator.pop(context, true);
            _showSnackBar(
              title: context.t.treatment.titleSuccessCanceledSnackBar,
            );
          },
        );
      },
      onError: (message) {
        Navigator.pop(context, false);
        _showSnackBar(title: message, isSuccess: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.t.treatment.confirmation,
                style: AppTextStyle.headingXSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                context.t.treatment.questionCancelReservation,
                style: AppTextStyle.w700TextColor16Px,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildContent(),
              const SizedBox(height: 16),
              _buildActions(),
            ],
          ),
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
                title: context.t.treatment.ok,
                onPressed: () {
                  _handleCancelAppointment();
                },
                buttonType: ButtonType.info,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Flexible(
      fit: FlexFit.loose,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContentItem(
              title: context.t.treatment.item,
              contentWidget: Text(
                _appointment.medicalTreatment.name,
                style: AppTextStyle.bodySmall,
              ),
            ),
            const SizedBox(height: 12),
            _buildContentItem(
              title: context.t.treatment.dateAndTime,
              contentWidget: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Utils.formatDateWithWeekday(
                        _appointment.bookingDate,
                      ),
                    ),
                    TextSpan(
                      text: ' ${_appointment.time.startTime}',
                    ),
                    TextSpan(
                      text: ' - ${_appointment.time.endTime}',
                    ),
                  ],
                  style: AppTextStyle.bodySmall,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildContentItem(
              title: context.t.treatment.reason,
              contentWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _reasons
                    .map(
                      (reason) => Text(reason, style: AppTextStyle.bodySmall),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Row _buildContentItem({
    required String title,
    required Widget contentWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.w700TextColor14Px,
        ),
        const SizedBox(width: 24),
        Expanded(child: contentWidget),
      ],
    );
  }
}
