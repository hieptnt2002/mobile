import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/widget/stage_change_email_password_widget.dart';

class CompleteChangePasswordScreen extends StatelessWidget {
  const CompleteChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final multiLanguage = context.t.forgotPassword;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(context.t.home.onlineClinic),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                multiLanguage.completeChangeTitle,
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
                            step: 3,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            multiLanguage.completeChangeText1,
                            style: AppTextStyle.labelMedium,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            multiLanguage.completeChangeText2,
                            style: AppTextStyle.bodyXSmall,
                          ),
                          const SizedBox(height: 30),
                          _buildButtonToLoginPage(context, multiLanguage),
                          const SizedBox(height: 30),
                          Text(
                            multiLanguage.completeChangeText3,
                            style: AppTextStyle.bodyXSmall,
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
  }

  Widget _buildButtonToLoginPage(BuildContext context, multiLanguage) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );
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
        multiLanguage.completeChangeButtonBackLogin,
        style: AppTextStyle.blackHeadingXXSmall,
      ),
    );
  }
}
