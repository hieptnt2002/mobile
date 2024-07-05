import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/login/login_view_model.dart';
import 'package:make_appointment_app/presentation/screens/widgets/text_field_widget.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final multiLanguage = context.t.login;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(context.t.home.onlineClinic),
        centerTitle: true,
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          multiLanguage.titleLogin,
                          style: AppTextStyle.blackHeadingXXSmall,
                        ),
                        const SizedBox(height: 20),
                        _buildTextFormFieldEmail(multiLanguage),
                        const SizedBox(height: 15),
                        _buildTextFormFieldPassword(multiLanguage),
                        const SizedBox(height: 30),
                        _buildCommonButton(viewModel, context, multiLanguage),
                        const SizedBox(height: 30),
                        _buildForgotPassword(context, viewModel, multiLanguage),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildNewUserDivide(multiLanguage),
                  _buildButtonRegister(context, multiLanguage),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFormFieldPassword(multiLanguage) {
    return TextFieldWidget(
      controller: _passwordController,
      hintText: multiLanguage.hintTextFieldFormPassword,
      obscureText: true,
      name: t.login.nameTextFieldFormPassword,
    );
  }

  Widget _buildTextFormFieldEmail(multiLanguage) {
    return TextFieldWidget(
      controller: _emailController,
      hintText: multiLanguage.hintTextFieldFormEmail,
      emailAddress: TextInputType.emailAddress,
      name: multiLanguage.nameTextFieldFormEmail,
    );
  }

  Widget _buildCommonButton(
    LoginViewModel viewModel,
    BuildContext context,
    multiLanguage,
  ) {
    return CommonButton(
      title: multiLanguage.nameButtonLogin,
      buttonType: ButtonType.warning,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.login(
            context: context,
            email: _emailController.text,
            password: _passwordController.text,
            onSuccess: () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.home,
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
    );
  }

  Widget _buildNewUserDivide(multiLanguage) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            height: 1,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),
        Text(
          multiLanguage.dividerNewUser,
          style: AppTextStyle.bodyXSmall,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            height: 1,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword(
    BuildContext context,
    LoginViewModel viewModel,
    multiLanguage,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.arrow_right,
          color: Colors.grey,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.forgotPassword);
          },
          child: Text(
            multiLanguage.forgotPassword,
            style: AppTextStyle.darkNavyBodyXSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonRegister(BuildContext context, multiLanguage) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.register);
              },
              child: Text(
                multiLanguage.nameButtonRegister,
                style: AppTextStyle.bodySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
