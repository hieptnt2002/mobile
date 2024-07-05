import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/widget/stage_change_email_password_widget.dart';
import 'package:make_appointment_app/presentation/screens/widgets/text_field_widget.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailResetPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailResetPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final multiLanguage = context.t.forgotPassword;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(context.t.home.onlineClinic),
        centerTitle: true,
      ),
      body: Consumer<ForgotPasswordViewModel>(
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
                      multiLanguage.screenTitle,
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
                                const SizedBox(height: 10),
                                const StageChangeEmailPasswordWidget(
                                  step: 1,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  multiLanguage.screenBodyText1,
                                  style: AppTextStyle.bodyXSmall,
                                ),
                                Text(
                                  multiLanguage.screenBodyText2,
                                  style: AppTextStyle.darkGreyBodyXSmall,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  multiLanguage.screenFormEmailTitle,
                                  style: AppTextStyle.labelMedium,
                                ),
                                const SizedBox(height: 8),
                                _buildTextFormFieldEmail(multiLanguage),
                                const SizedBox(height: 30),
                                Text(
                                  multiLanguage.screenBodyText3,
                                  style: AppTextStyle.bodyXSmall,
                                ),
                                const SizedBox(height: 20),
                                _buildButtonSendmail(
                                  viewModel,
                                  context,
                                  multiLanguage,
                                ),
                                const SizedBox(height: 20),
                                _buildButtonCancel(context, multiLanguage),
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

  Widget _buildTextFormFieldEmail(multiLanguage) {
    return TextFieldWidget(
      name: multiLanguage.screenFormEmailName,
      controller: _emailResetPassword,
      emailAddress: TextInputType.emailAddress,
    );
  }

  Widget _buildButtonCancel(BuildContext context, multiLanguage) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
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
        multiLanguage.screenButtonCancel,
        style: AppTextStyle.blackHeadingXXSmall,
      ),
    );
  }

  Widget _buildButtonSendmail(
    ForgotPasswordViewModel viewModel,
    BuildContext context,
    multiLanguage,
  ) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.resetPassword(
            context: context,
            email: _emailResetPassword.text,
            onSuccess: () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.changePassword,
                  (route) => false,
                );
              });
            },
            onError: (message) {
              Utils.showErrorDialog(message: message);
            },
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
        multiLanguage.screenButtonSendMail,
        style: AppTextStyle.blackHeadingXXSmall,
      ),
    );
  }
}
