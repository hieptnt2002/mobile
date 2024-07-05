import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';

import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/register/widget/stage_register_widget.dart';

class CompleteRegisterScreen extends StatelessWidget {
  const CompleteRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(context.t.home.onlineClinic),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: heightScreen,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.t.register.completeRegisterScreenTitle,
                    style: AppTextStyle.blackHeadingXSmall,
                  ),
                ],
              ),
              const StageRegisterWidget(step: 3),
              const SizedBox(height: 20),
              Text(
                context.t.register.completeRegisterScreenBodyHeading,
                style: AppTextStyle.darkRedHeadingXXSmall,
              ),
              const SizedBox(height: 10),
              Text(
                context.t.register.completeRegisterScreenBodyContent,
              ),
              const SizedBox(height: 20),
              _buildButtonToLoginPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonToLoginPage(BuildContext context) {
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
        context.t.register.completeRegisterScreenButtonBackLogin,
        style: AppTextStyle.blackHeadingXXSmall,
      ),
    );
  }
}
