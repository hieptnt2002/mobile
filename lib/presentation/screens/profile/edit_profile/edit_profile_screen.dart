import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/address.dart';
import 'package:make_appointment_app/data/models/user.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/components/dropdown/common_dropdown_menu.dart';
import 'package:make_appointment_app/presentation/components/ratio_button/custom_radio_button.dart';
import 'package:make_appointment_app/presentation/components/text_field/common_text_form_field.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/edit_profile_view_model.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/widgets/edit_address.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/widgets/main_address.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _viewModel = context.read<EditProfileViewModel>();
  late var gender = widget.user.gender ?? 0;
  Prefecture? prefecture;
  late final _firstNameController =
      TextEditingController(text: widget.user.firstName);
  late final _lastNameController =
      TextEditingController(text: widget.user.lastName);
  late final _firstFuriganaController =
      TextEditingController(text: widget.user.firstHiragana);
  late final _lastFuriganaController =
      TextEditingController(text: widget.user.firstHiragana);
  late final _phoneNumberController = TextEditingController();
  late final _postCodeController = TextEditingController();
  late final _municipalitiesController = TextEditingController();
  late final _streetController = TextEditingController();

  void _showUpdateSuccessDialog() {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (ctx) {
            return CustomDialog(
              title: context.t.editProfile.success,
              content: context.t.editProfile.successfullyUpdated,
              actions: [
                DialogActionButton(
                  onTap: () {
                    Navigator.of(ctx).pop();
                  },
                  title: context.t.editProfile.ok,
                ),
              ],
            );
          },
        ).then((value) {
          Navigator.of(context).pop(true);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstFuriganaController.dispose();
    _lastFuriganaController.dispose();
    _phoneNumberController.dispose();
    _postCodeController.dispose();
    _municipalitiesController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.editProfile.editProfile)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildName(),
            _buildFurigina(),
            _buildSelectGender(),
            _buildBirthday(),
            _buildEmail(),
            MainAddress(
              phoneNumberController: _phoneNumberController,
              postCodeController: _postCodeController,
              municipalitiesController: _municipalitiesController,
              streetController: _streetController,
              onSelectPrefecture: (value) {
                prefecture = value;
              },
            ),
            const SizedBox(height: 12),
            EditAddress(
              fullName: '${widget.user.firstName} ${widget.user.lastName}',
            ),
            _buildRegistrationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationButton() {
    return SafeArea(
      child: CommonButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final user = widget.user.copyWith(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              firstHiragana: _firstFuriganaController.text,
              lastHiragana: _lastFuriganaController.text,
              gender: gender,
            );
            final mainAddress = _viewModel.mainAddress?.copyWith(
              address: _streetController.text,
              municipality: _municipalitiesController.text,
              phone: _phoneNumberController.text,
              zipCode: _postCodeController.text,
              prefecture: prefecture,
            );

            await _viewModel.updateProfile(user, mainAddress, (_) {
              if (mounted) {
                _showUpdateSuccessDialog();
              }
            });
          }
        },
        title: context.t.editProfile.registration,
        buttonType: ButtonType.info,
      ),
    );
  }

  Widget _buildSelectGender() {
    return StatefulBuilder(
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 20),
              child: Text(
                context.t.editProfile.gender,
                style: AppTextStyle.headingXXSmall,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomRadioButton(
                        value: 1,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      Flexible(child: Text(context.t.editProfile.male)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomRadioButton(
                        value: 0,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      Flexible(child: Text(context.t.editProfile.female)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.name,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        CommonTextFormField(controller: _firstNameController),
        const SizedBox(height: 20),
        CommonTextFormField(controller: _lastNameController),
      ],
    );
  }

  Widget _buildFurigina() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.furigina,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        CommonTextFormField(controller: _firstFuriganaController),
        const SizedBox(height: 20),
        CommonTextFormField(controller: _lastFuriganaController),
      ],
    );
  }

  Widget _buildBirthday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.birthday,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CommonDropdownMenu(
                disable: true,
                initialValue: CommonDropdownMenuItemData(
                  text: widget.user.dateOfBirth?.year.toString() ?? '',
                ),
                values: [
                  CommonDropdownMenuItemData(
                    text: widget.user.dateOfBirth?.year.toString() ?? '',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Text(context.t.editProfile.year),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CommonDropdownMenu(
                disable: true,
                initialValue: CommonDropdownMenuItemData(
                  text: widget.user.dateOfBirth?.month.toString() ?? '',
                ),
                values: [
                  CommonDropdownMenuItemData(
                    text: widget.user.dateOfBirth?.month.toString() ?? '',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Text(context.t.editProfile.month),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CommonDropdownMenu(
                disable: true,
                initialValue: CommonDropdownMenuItemData(
                  text: widget.user.dateOfBirth?.day.toString() ?? '',
                ),
                values: [
                  CommonDropdownMenuItemData(
                    text: widget.user.dateOfBirth?.day.toString() ?? '',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Text(context.t.editProfile.day),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(
            context.t.editProfile.emailAddress,
            style: AppTextStyle.headingXXSmall,
          ),
        ),
        CommonTextFormField(
          enabled: false,
          hintText: widget.user.email,
          required: false,
        ),
      ],
    );
  }
}
