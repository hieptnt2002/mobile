import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/line_dash/line_dash.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_list/widgets/completed_treatment_item.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_list/widgets/pending_treatment_item.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_list/treatment_list_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentListScreen extends StatelessWidget {
  const TreatmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TreatmentListViewModel>(
      builder: (context, viewModel, child) {
        final pendingAppointments = viewModel.pendingAppointments;
        final completedAppointments = viewModel.completedAppointments;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.t.treatment.appBarTitleTreatmentList),
            ),
            body: Column(
              children: [
                _buildTabBar(context),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildPendingTreatmentTabView(pendingAppointments),
                      _buildTreatmentCompletedTabView(completedAppointments),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(text: context.t.treatment.waitingTreatment),
        Tab(text: context.t.treatment.treatmentCompleted),
      ],
      indicatorWeight: 4,
      indicatorColor: AppColors.cyan,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.cyan,
      labelStyle: AppTextStyle.labelMedium,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
    );
  }

  Widget _buildTreatmentCompletedTabView(
    List<Appointment> completedAppointments,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return CompletedTreatmentItem(
          appointment: completedAppointments[index],
        );
      },
      separatorBuilder: (context, index) => const LineDash(height: 0.5),
      itemCount: completedAppointments.length,
    );
  }

  Widget _buildPendingTreatmentTabView(List<Appointment> pendingAppointments) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) => PendingTreatmentItem(
        appointment: pendingAppointments[index],
      ),
      itemCount: pendingAppointments.length,
      separatorBuilder: (context, index) => const LineDash(height: 0.5),
    );
  }
}
