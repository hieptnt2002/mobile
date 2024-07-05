import 'package:flutter/material.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/appointment/appointment_view_model.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class ConfirmAppointmentScreen extends StatefulWidget {
  final bool isFirstVisit;
  final DateTime date;
  final int timeId;
  final String time;
  final MedicalTreatment medicalTreatment;
  const ConfirmAppointmentScreen({
    super.key,
    required this.isFirstVisit,
    required this.date,
    required this.time,
    required this.timeId,
    required this.medicalTreatment,
  });

  @override
  State<ConfirmAppointmentScreen> createState() =>
      _ConfirmAppointmentScreenState();
}

class _ConfirmAppointmentScreenState extends State<ConfirmAppointmentScreen> {
  bool _isSubscribed = false;
  late final _viewModel = context.read<AppointmentViewModel>();

  void showCreateAppointmentSuccessDialog() {
    Future.delayed(Duration.zero, () {
      showDialog(
        barrierDismissible: false,
        context: Utils.navigatorKey.currentState!.context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: CustomDialog(
              title: context.t.confirmAppointment.treatmentAppointmentCompleted,
              content: context
                  .t.confirmAppointment.treatmentAppointmentCompletedContent,
              actions: [
                DialogActionButton(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(Routes.home, (route) => false);
                  },
                  title: context.t.confirmAppointment.ok,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  void showUpdateInformationRequired() {
    Future.delayed(Duration.zero, () {
      showDialog(
        barrierDismissible: false,
        context: Utils.navigatorKey.currentState!.context,
        builder: (context) {
          return CustomDialog(
            title: context.t.confirmAppointment.updateProfileRequired,
            content: context.t.confirmAppointment.updateProfileRequiredContent,
            actions: [
              DialogActionButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: context.t.confirmAppointment.ok,
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.confirmAppointment.appBarTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        children: [
          _buildTreatmentInformation(),
          _buildCoupon(),
          _buildEmailMagazineSubscription(),
          const SizedBox(height: 12),
          _buildNotes(),
          const SizedBox(height: 20),
          CommonButton(
            onPressed: () {
              _viewModel.createAppointment(
                medicalId: widget.medicalTreatment.id,
                date: widget.date,
                timeId: widget.timeId,
                isFirstVisit: widget.isFirstVisit,
                onSuccess: () {
                  showCreateAppointmentSuccessDialog();
                },
                onError: (message) {
                  if (message == 'UPDATE_INFORMATION_REQUIRED') {
                    showUpdateInformationRequired();
                  } else if (message == ApiExceptionType.tokenExpires.name) {
                    Utils.showTokenExpiredDialog();
                  } else {
                    Utils.showErrorDialog();
                  }
                },
              );
            },
            title: context.t.confirmAppointment.makeAReservation,
            buttonType: ButtonType.info,
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.cyan,
              minimumSize: const Size(double.infinity, double.minPositive),
            ),
            child: Text(context.t.confirmAppointment.cancel),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context.t.confirmAppointment.treatmentItems),
        Text(widget.medicalTreatment.name, style: AppTextStyle.bodyMedium),
        _buildTitle(context.t.confirmAppointment.treatmentStartDateAndTime),
        Text(formatDateTime(widget.time), style: AppTextStyle.bodyMedium),
      ],
    );
  }

  Widget _buildCoupon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context.t.confirmAppointment.couponCode),
        const SizedBox(height: 8),
        _buildCouponCodeTextField(),
      ],
    );
  }

  Widget _buildEmailMagazineSubscription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context.t.confirmAppointment.emailMagazineSubscription),
        Row(
          children: [
            StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Checkbox(
                  activeColor: AppColors.cyan,
                  value: _isSubscribed,
                  onChanged: (value) {
                    setState(() {
                      _isSubscribed = !_isSubscribed;
                    });
                  },
                );
              },
            ),
            Expanded(
              child: Text(
                context.t.confirmAppointment.emailMagazineSubscriptionNote,
              ),
            ),
          ],
        ),
        Text(
          context.t.confirmAppointment.emailMagazineSubscriptionNoteTwo,
          style: AppTextStyle.bodySmall,
        ),
      ],
    );
  }

  Widget _buildNotes() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.lightGray,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.t.confirmAppointment.notes,
            style: AppTextStyle.headingXXSmall,
          ),
          const SizedBox(height: 8),
          Text(
            context.t.confirmAppointment.notesTwo,
            style: AppTextStyle.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: AppTextStyle.headingXSmall,
      ),
    );
  }

  Widget _buildCouponCodeTextField() {
    return TextField(
      decoration: InputDecoration(
        hintText: context.t.confirmAppointment.enterYourCouponCode,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 2, color: AppColors.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 2, color: AppColors.lightGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 2, color: AppColors.lightGray),
        ),
      ),
    );
  }

  String formatDateTime(String time) {
    List<String> parts = time.split(':');
    String hour = parts[0];
    int? minute = int.tryParse(parts[1]);
    final toMinute = (minute ?? 0) + 14;
    return '${time.substring(0, 5)} - $hour:$toMinute start';
  }
}
