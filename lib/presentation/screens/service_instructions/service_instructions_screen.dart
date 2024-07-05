import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';

import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class ServiceInstructionsScreen extends StatelessWidget {
  const ServiceInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.serviceInstructions.appBarTitle),
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        color: AppColors.aliceBlue,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    context.t.serviceInstructions.firstConsultationAppointment,
                    style: AppTextStyle.headingXSmall,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      context.t.serviceInstructions.appointment,
                      style: AppTextStyle.w700Turquoise14Px,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.t.serviceInstructions.explainTheReservationProcess,
                    style: AppTextStyle.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  ...context.t.serviceInstructions.instructions.map(
                    (instruction) => _buildInstructionItem(
                      stepIndex: instruction.stepIndex,
                      title: instruction.title,
                      thumbnail: instruction.thumbnail,
                      content: instruction.content,
                      reminder: instruction.reminder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem({
    required String stepIndex,
    required String title,
    required String thumbnail,
    required String content,
    required String reminder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.textColor,
              ),
              child: Text(stepIndex, style: AppTextStyle.w700White16Px),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: AppTextStyle.w700TextColor16Px),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Image.network(thumbnail, width: 179, height: 228),
        ),
        const SizedBox(height: 16),
        Text(content, style: AppTextStyle.bodySmall),
        if (reminder.isNotEmpty) Text(reminder, style: AppTextStyle.bodySmall),
        const SizedBox(height: 32),
        const Divider(thickness: 0.5, color: AppColors.lightGray),
      ],
    );
  }
}
