import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/register/verify_email_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/register/widget/stage_register_widget.dart';
import 'package:make_appointment_app/presentation/screens/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class VerifyEmailRegisterScreen extends StatefulWidget {
  const VerifyEmailRegisterScreen({
    super.key,
  });

  @override
  State<VerifyEmailRegisterScreen> createState() =>
      _VerifyEmailRegisterScreenState();
}

class _VerifyEmailRegisterScreenState extends State<VerifyEmailRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeRegisterController = TextEditingController();
  @override
  void dispose() {
    _codeRegisterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<VerifyEmailViewModel>();
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.home.onlineClinic),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: heightScreen,
            padding: const EdgeInsets.all(15),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.t.register.verifyEmailScreenTitle,
                      style: AppTextStyle.blackHeadingXSmall,
                    ),
                  ],
                ),
                const StageRegisterWidget(step: 2),
                const SizedBox(height: 10),
                Text(
                  context.t.register.verifyEmailScreenBodyHeading,
                  style: AppTextStyle.darkRedHeadingXXSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  context.t.register.verifyEmailScreenBodyContent,
                ),
                const SizedBox(height: 15),
                Text(
                  context.t.register.verifyEmailScreenAuthenticationCode,
                  style: AppTextStyle.blackHeadingXSmall,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: _codeRegisterController,
                  name: context.t.register.verifyEmailScreenCodeFormFieldName,
                ),
                const SizedBox(height: 30),
                _buildButtonRegister(context, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRegister(
    BuildContext context,
    VerifyEmailViewModel viewModel,
  ) {
    return CommonButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.verifyEmailRegister(
            code: _codeRegisterController.text,
            onSuccess: () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.completeRegister,
                  (route) => false,
                );
              });
            },
          );
        }
      },
      title: context.t.register.verifyEmailScreenButtonRegisterName,
      buttonType: ButtonType.warning,
    );
  }
}
