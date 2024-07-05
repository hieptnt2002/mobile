import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:make_appointment_app/data/models/address.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/helper/iterable_extensions.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/profile/base_profile/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.profile.appBarTitle),
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
          final userData = viewModel.user;
          if (userData == null) return const SizedBox();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildProfileItem(
                title: context.t.profile.medicalRecordNumber,
                content: userData.medicalNumber.toString(),
              ),
              _buildProfileItem(
                title: context.t.profile.name,
                content: '${userData.firstName} ${userData.lastName}',
              ),
              _buildProfileItem(
                title: context.t.profile.hiragana,
                content: '${userData.firstHiragana} ${userData.lastHiragana}',
              ),
              _buildProfileItem(
                title: context.t.profile.gender,
                content: userData.gender == 1
                    ? context.t.profile.male
                    : context.t.profile.female,
              ),
              _buildProfileItem(
                title: context.t.profile.birthday,
                content: userData.dateOfBirth == null
                    ? ''
                    : DateFormat('MMMM d, yyyy').format(userData.dateOfBirth!),
                subtitle: context.t.profile.birthdayNote,
              ),
              _buildProfileItem(
                title: context.t.profile.emailAddress,
                content: userData.email,
                subtitle: context.t.profile.emailAddressNote,
              ),
              _buildProfileItem(
                title: context.t.profile.phoneNumber,
                content: viewModel.defaultAddress?.phone ?? '',
              ),
              _buildProfileItem(
                title: context.t.profile.creditCard,
                content: (userData.creditCard ?? '').isNotEmpty
                    ? userData.creditCard ?? ''
                    : context.t.profile.emptyCreditCard,
              ),
              if (viewModel.defaultAddress != null)
                _buildProfileItem(
                  title: context.t.profile.address,
                  content:
                      '${viewModel.defaultAddress?.address ?? ''}, ${viewModel.defaultAddress?.prefecture.name ?? ''}, ${viewModel.defaultAddress?.municipality ?? ''}, ${viewModel.defaultAddress?.zipCode ?? ''}',
                ),
              ...viewModel.allAddresses.mapIndexed((index, e) {
                return _buildDeliveryAddress(context, e, index);
              }),
              _buildChangePasswordButton(context),
              const SizedBox(height: 16),
              SafeArea(
                child: CommonButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Routes.editProfile,
                      arguments: {
                        'user': userData,
                      },
                    ).then((reload) {
                      if (reload == true) {
                        viewModel.getProfileData();
                      }
                    });
                  },
                  title: context.t.profile.changeBasicInformation,
                  buttonType: ButtonType.info,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.changePassword);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1, color: Colors.grey),
        ),
        fixedSize: const Size(double.maxFinite, 60.0),
        backgroundColor: AppColors.white,
        shadowColor: Colors.transparent,
      ),
      child: Text(
        context.t.profile.changeYourPassword,
        style: AppTextStyle.bodyLarge,
      ),
    );
  }

  Widget _buildProfileItem({
    required String title,
    required String content,
    String subtitle = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.headingXXSmall),
        const SizedBox(height: 6),
        Text(content, style: AppTextStyle.bodyMedium),
        if (subtitle.isNotEmpty) const SizedBox(height: 6),
        if (subtitle.isNotEmpty) Text(subtitle, style: AppTextStyle.bodyXSmall),
        const SizedBox(height: 6),
        Divider(color: Colors.grey.shade200),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDeliveryAddress(
    BuildContext context,
    Address address,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${context.t.profile.deliveryAddress} ${index + 1}',
              style: AppTextStyle.headingXXSmall,
            ),
            const SizedBox(width: 8),
            if (address.defaultFlg == 1)
              Flexible(
                child: Text(
                  context.t.profile.defaultText,
                  style: AppTextStyle.cyanLabelMedium,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(address.phone, style: AppTextStyle.bodyMedium),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            '${address.address}, ${address.prefecture.name}, ${address.municipality}, ${address.zipCode}',
            style: AppTextStyle.bodyMedium,
          ),
        ),
        Divider(color: Colors.grey.shade200),
        const SizedBox(height: 20),
      ],
    );
  }
}
