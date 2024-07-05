import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment_time.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/components/ratio_button/custom_radio_button.dart';
import 'package:make_appointment_app/presentation/screens/appointment/appointment_view_model.dart';
import 'package:make_appointment_app/presentation/screens/appointment/widgets/appointment_time_item.dart';
import 'package:make_appointment_app/presentation/screens/widgets/calendar/custom_calendar_date_picker.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  final MedicalTreatment? medicalTreatment;
  const AppointmentScreen({super.key, required this.medicalTreatment});
  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  var _isFirstVisit = true;
  var _showLateNight = false;
  late MedicalTreatment? _medicalTreatment = widget.medicalTreatment;
  bool get showCalendarPicker => _medicalTreatment != null;
  var _dateSelected = DateTime.now();
  late final _viewModel = context.read<AppointmentViewModel>();

  @override
  void initState() {
    if (widget.medicalTreatment != null) {
      _viewModel.getAllAppointmentTimeInDate(
        date: _dateSelected,
        medicalTreatmentId: _medicalTreatment!.id,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.appointment.appointments)),
      body: Consumer<AppointmentViewModel>(
        builder: (context, viewModel, _) {
          final hasAppointmentTime =
              viewModel.timeOfMorningAppointment.isNotEmpty;
          return CustomScrollView(
            slivers: [
              _buildSelectAMedicalSpecialty(),
              _buildSelectDateTime(),
              if (hasAppointmentTime) _buildShowLateNightCheckBox(),
              if (hasAppointmentTime && _showLateNight)
                _buildTitle(context.t.appointment.lateNight),
              if (hasAppointmentTime && _showLateNight)
                if (hasAppointmentTime)
                  _buildTimeGrid(viewModel.timeOfLateNightAppointment),
              if (hasAppointmentTime)
                _buildTitle(context.t.appointment.morning),
              if (hasAppointmentTime)
                _buildTimeGrid(viewModel.timeOfMorningAppointment),
              if (hasAppointmentTime)
                _buildTitle(context.t.appointment.afternoon),
              if (hasAppointmentTime)
                _buildTimeGrid(viewModel.timeOfAfternoonAppointment),
              if (hasAppointmentTime)
                _buildTitle(context.t.appointment.evening),
              if (hasAppointmentTime)
                _buildTimeGrid(viewModel.timeOfEveningAppointment),
              if (hasAppointmentTime && _showLateNight)
                _buildTitle(context.t.appointment.night),
              if (hasAppointmentTime && _showLateNight)
                if (hasAppointmentTime)
                  _buildTimeGrid(viewModel.timeOfNightAppointment),
              if (hasAppointmentTime) _buildNotes(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSelectAMedicalSpecialty() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.appointment.selectMedicalSpecialty,
              style: AppTextStyle.headingXSmall,
            ),
            Text(
              context.t.appointment.pleaseSelectSpecialistAndMakeReservation,
              style: AppTextStyle.bodyMedium,
            ),
            _buildSelectMedicalDropdown(),
            Text(
              context.t.appointment.pleaseSelectMenuMedicalDepartment,
              style: AppTextStyle.labelLarge,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.t.appointment.initialVisit,
                    style: AppTextStyle.labelSmall,
                  ),
                  TextSpan(
                    text: context.t.appointment.firstTimeDeptVisitors,
                    style: AppTextStyle.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.t.appointment.reExamination,
                    style: AppTextStyle.labelSmall,
                  ),
                  TextSpan(
                    text: context.t.appointment.repeatDeptVisitors,
                    style: AppTextStyle.bodySmall,
                  ),
                ],
              ),
            ),
            _buildRatioButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectMedicalDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: AppColors.lightGray,
        ),
      ),
      child: DropdownButton<MedicalTreatment?>(
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 42,
        isExpanded: true,
        style: AppTextStyle.bodyMedium,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        value: _medicalTreatment,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(context.t.appointment.pleaseSelect),
          ),
          ..._viewModel.medicalTreatmentList
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
        ],
        onChanged: (value) {
          setState(() {
            _medicalTreatment = value;
          });
          if (value != null) {
            _viewModel.getAllAppointmentTimeInDate(
              date: _dateSelected,
              medicalTreatmentId: value.id,
            );
          } else {
            _viewModel.clearAllAppointmentTimeInDate();
          }
        },
      ),
    );
  }

  Widget _buildRatioButton() {
    return Row(
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRadioButton(
                value: true,
                groupValue: _isFirstVisit,
                onChanged: (isFirstVisit) {
                  setState(() {
                    _isFirstVisit = isFirstVisit;
                  });
                },
              ),
              Flexible(child: Text(context.t.appointment.firstVisit)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRadioButton(
                value: false,
                groupValue: _isFirstVisit,
                onChanged: (isFirstVisit) {
                  setState(() {
                    _isFirstVisit = isFirstVisit;
                  });
                },
              ),
              Flexible(child: Text(context.t.appointment.returnVisit)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectDateTime() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.appointment.selectDateTreatment,
              style: AppTextStyle.headingXSmall,
            ),
            const SizedBox(height: 16),
            if (showCalendarPicker)
              CustomCalendarDatePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 10)),
                initialDate: _dateSelected,
                onDateChanged: (value) {
                  _dateSelected = value;
                  _viewModel.getAllAppointmentTimeInDate(
                    date: _dateSelected,
                    medicalTreatmentId: _medicalTreatment!.id,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowLateNightCheckBox() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.cyan,
            value: _showLateNight,
            onChanged: (value) {
              setState(() {
                _showLateNight = !_showLateNight;
              });
            },
          ),
          Text(
            context.t.appointment.showLateNight,
            style: AppTextStyle.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  _buildNoteContainer(AppointmentTimeStatus.AVAILABLE),
                  Text(
                    context.t.appointment.available,
                    style: AppTextStyle.bodyLarge,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    _buildNoteContainer(AppointmentTimeStatus.ALERT),
                    Text(
                      context.t.appointment.onlyAFewLeft,
                      style: AppTextStyle.bodyLarge,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildNoteContainer(AppointmentTimeStatus.CLOSE),
                  Text(
                    context.t.appointment.noVacancy,
                    style: AppTextStyle.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteContainer(AppointmentTimeStatus status) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 80,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 2,
          color: getTimeGridItemColor(status),
        ),
      ),
    );
  }

  Widget _buildTimeGrid(List<AppointmentTime> appointmentTimes) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 2.5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final appointmentTime = appointmentTimes[index];
            final color = getTimeGridItemColor(appointmentTime.status);
            return AppointmentTimeItem(
              color: color,
              time: appointmentTime.time,
              status: appointmentTime.status,
              isFirstVisit: _isFirstVisit,
              medicalTreatment: _medicalTreatment,
              date: _dateSelected,
              timeId: appointmentTime.timeId,
            );
          },
          childCount: appointmentTimes.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTitle(String time) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          time,
          style: AppTextStyle.labelLarge,
        ),
      ),
    );
  }

  Color getTimeGridItemColor(AppointmentTimeStatus status) {
    switch (status) {
      case AppointmentTimeStatus.AVAILABLE:
        return AppColors.green;
      case AppointmentTimeStatus.ALERT:
        return AppColors.yellow;
      case AppointmentTimeStatus.CLOSE:
        return AppColors.lightGray;
      case AppointmentTimeStatus.NONE:
        return AppColors.lightGray;
    }
  }
}
