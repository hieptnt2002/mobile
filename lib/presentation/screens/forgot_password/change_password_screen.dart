import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/change_password_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/widget/stage_change_email_password_widget.dart';
import 'package:make_appointment_app/presentation/screens/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _newPassword = TextEditingController();
  final _oldPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _code = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPassword.dispose();
    _confirmPassword.dispose();
    _newPassword.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var multiLanguage = context.t.forgotPassword;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(context.t.home.onlineClinic),
        centerTitle: true,
      ),
      body: Consumer<ChangePasswordViewModel>(
        builder: (context, viewModel, _) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      multiLanguage.changePasswordTitle,
                      style: AppTextStyle.labelMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //const SizedBox(height: 10),
                                const StageChangeEmailPasswordWidget(
                                  step: 2,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  multiLanguage.changePasswordText1,
                                  style: AppTextStyle.bodyXSmall,
                                ),
                                const SizedBox(height: 10),
                                viewModel.isLoggedIn
                                    ? _buildTextFormFieldOldPassword(
                                        multiLanguage,
                                      )
                                    : Container(),
                                Text(
                                  multiLanguage
                                      .changePasswordFormNewPasswordTitle,
                                  style: AppTextStyle.labelSmall,
                                ),
                                const SizedBox(height: 8),
                                _buildTextFormFieldPassword(multiLanguage),

                                const SizedBox(height: 8),
                                Text(
                                  multiLanguage
                                      .changePasswordFormConfirmNewPasswordTitle,
                                  style: AppTextStyle.labelSmall,
                                ),
                                const SizedBox(height: 8),
                                _buildTextFormFieldConfirmPassword(
                                  multiLanguage,
                                ),
                                const SizedBox(height: 8),
                                viewModel.isLoggedIn
                                    ? Container()
                                    : _buildTextFormFieldCode(multiLanguage),
                                const SizedBox(height: 8),
                                Text(
                                  multiLanguage.changePasswordText2,
                                  style: AppTextStyle.darkGreyBodyXXSmall,
                                ),
                                const SizedBox(height: 20),
                                _buildButtonChangePassword(
                                  viewModel,
                                  context,
                                  multiLanguage,
                                ),
                                const SizedBox(height: 20),
                                _buildButtonCancel(
                                  context,
                                  viewModel,
                                  multiLanguage,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFormFieldOldPassword(multiLanguage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          multiLanguage.changePasswordFormOldPassword,
          style: AppTextStyle.labelSmall,
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          name: multiLanguage.changePasswordFormOldPasswordName,
          controller: _oldPassword,
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildTextFormFieldPassword(multiLanguage) {
    return TextFieldWidget(
      name: multiLanguage.changePasswordFormNewPasswordName,
      controller: _newPassword,
      obscureText: true,
    );
  }

  Widget _buildTextFormFieldConfirmPassword(multiLanguage) {
    return TextFieldWidget(
      name: multiLanguage.changePasswordFormConfirmPasswordName,
      controller: _confirmPassword,
      obscureText: true,
      passwordEditingController: _newPassword,
    );
  }

  Widget _buildTextFormFieldCode(multiLanguage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          multiLanguage.changePasswordFormCodeTitle,
          style: AppTextStyle.labelSmall,
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          name: multiLanguage.changePasswordFormCodeName,
          controller: _code,
        ),
      ],
    );
  }

  Widget _buildButtonCancel(
    BuildContext context,
    ChangePasswordViewModel viewModel,
    multiLanguage,
  ) {
    return ElevatedButton(
      onPressed: () {
        if (viewModel.isLoggedIn) {
          Navigator.of(context).pushNamed(Routes.home);
        } else {
          Navigator.of(context).pushNamed(Routes.login);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(width: 2, color: Colors.black),
        ),
        fixedSize: const Size(double.maxFinite, 50.0),
        backgroundColor: AppColors.white,
        shadowColor: Colors.transparent,
      ),
      child: Text(
        multiLanguage.changePasswordButtonCancel,
        style: AppTextStyle.blackHeadingXXSmall,
      ),
    );
  }

  Widget _buildButtonChangePassword(
    ChangePasswordViewModel viewModel,
    BuildContext context,
    multiLanguage,
  ) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.changePassword(
            oldPassword: _oldPassword.text,
            newPassword: _newPassword.text,
            token: _code.text,
            onSuccess: () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.completeResetPassword,
                  (route) => false,
                );
              });
            },
            onError: () {},
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        fixedSize: const Size(double.maxFinite, 50.0),
        backgroundColor: AppColors.yellow,
      ),
      child: Text(
        multiLanguage.changePasswordButtonRegisterPassword,
        style: AppTextStyle.blackHeadingXXSmall,
      ),
    );
  }
}
