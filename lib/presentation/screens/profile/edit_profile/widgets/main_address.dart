import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/address.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/dropdown/common_dropdown_menu.dart';
import 'package:make_appointment_app/presentation/components/text_field/common_text_form_field.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/edit_profile_view_model.dart';
import 'package:provider/provider.dart';

class MainAddress extends StatefulWidget {
  final TextEditingController phoneNumberController;
  final TextEditingController postCodeController;
  final TextEditingController municipalitiesController;
  final TextEditingController streetController;
  final void Function(Prefecture?)? onSelectPrefecture;
  const MainAddress({
    super.key,
    required this.phoneNumberController,
    required this.postCodeController,
    required this.municipalitiesController,
    required this.streetController,
    this.onSelectPrefecture,
  });

  @override
  State<MainAddress> createState() => _MainAddressState();
}

class _MainAddressState extends State<MainAddress> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.mainAddress == null) return const SizedBox();
        widget.phoneNumberController.text = viewModel.mainAddress!.phone;
        widget.postCodeController.text = viewModel.mainAddress!.zipCode;
        widget.municipalitiesController.text =
            viewModel.mainAddress!.municipality;
        widget.streetController.text = viewModel.mainAddress!.address;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumber(),
            _buildPostCode(),
            _buildPrefectures(viewModel),
            _buildMunicipalities(),
            _buildStreet(),
          ],
        );
      },
    );
  }

  Widget _buildPostCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.postCode,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        SizedBox(
          width: 200,
          child: CommonTextFormField(controller: widget.postCodeController),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.phoneNumber,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        CommonTextFormField(
          controller: widget.phoneNumberController,
        ),
      ],
    );
  }

  Widget _buildPrefectures(EditProfileViewModel viewModel) {
    final prefectures = viewModel.prefectures;
    final selectPrefecture = viewModel.mainAddress?.prefecture;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.prefectures,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        SizedBox(
          width: 200,
          child: CommonDropdownMenu<Prefecture>(
            initialValue: selectPrefecture == null
                ? null
                : CommonDropdownMenuItemData(
                    text: selectPrefecture.name,
                    value: selectPrefecture,
                  ),
            values: prefectures
                .map((e) => CommonDropdownMenuItemData(text: e.name, value: e))
                .toList(),
            onChanged: widget.onSelectPrefecture,
          ),
        ),
      ],
    );
  }

  Widget _buildMunicipalities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.municipalities,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        CommonTextFormField(
          controller: widget.municipalitiesController,
        ),
      ],
    );
  }

  Widget _buildStreet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.streetName,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        CommonTextFormField(
          controller: widget.streetController,
        ),
        const SizedBox(height: 10),
        Text(
          context.t.editProfile.streetNote,
          style: AppTextStyle.bodySmall,
        ),
        Text(
          context.t.editProfile.streetNoteTwo,
          style: AppTextStyle.bodySmall,
        ),
      ],
    );
  }
}
