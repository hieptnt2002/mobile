import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/ratio_button/custom_radio_button.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/edit_profile_view_model.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatefulWidget {
  final String fullName;
  const EditAddress({super.key, required this.fullName});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileViewModel>(
      builder: (context, viewModel, child) {
        final defaultDeliveryAddressId = viewModel.defaultDeliveryAddress?.id;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 20),
              child: Text(
                context.t.editProfile.addressee,
                style: AppTextStyle.headingXXSmall,
              ),
            ),
            Text(
              context.t.editProfile.addresseeNote,
              style: AppTextStyle.bodySmall,
            ),
            const SizedBox(height: 12),
            ...viewModel.allAddresses.map((e) {
              return Row(
                children: [
                  CustomRadioButton(
                    value: e.id,
                    groupValue: defaultDeliveryAddressId,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.fullName, style: AppTextStyle.labelSmall),
                        Text(e.phone, style: AppTextStyle.labelSmall),
                        Text(e.zipCode, style: AppTextStyle.labelSmall),
                        Text(
                          '${e.address} ${e.municipality} ${e.prefecture.name}',
                          style: AppTextStyle.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
