import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/register/register_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/register/widget/stage_register_widget.dart';
import 'package:make_appointment_app/presentation/screens/widgets/text_field_widget.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegisterController = TextEditingController();
  final _passwordRegisterController = TextEditingController();

  @override
  void dispose() {
    _emailRegisterController.dispose();
    _passwordRegisterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterViewModel>();
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
              children: [
                Row(
                  children: [
                    Text(
                      context.t.register.screenTitleHeading,
                      style: AppTextStyle.w500Black24px,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      context.t.register.screenTitleContent,
                      style: AppTextStyle.blackBodyXSmall,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                const StageRegisterWidget(step: 1),
                const SizedBox(height: 10),
                _buildRequireField(),
                const SizedBox(height: 10),
                _buildTextFormFieldEmail(),
                const SizedBox(height: 10),
                _buildRequireField(),
                const SizedBox(height: 10),
                _buildTextFormFieldPassword(),
                const SizedBox(height: 20),
                _buildButtonSendAuthentication(context, viewModel),
                const SizedBox(height: 20),
                Text(
                  context.t.register.screenTextBody,
                  style: AppTextStyle.blackBodyXSmall,
                ),
                const SizedBox(height: 20),
                _buildAlreadyRegisterDevice(),
                const SizedBox(height: 20),
                _buildLoginHereField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginHereField(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.login,
        );
      },
      child: Text(
        context.t.register.screenLinkLoginHere,
        style: const TextStyle(color: AppColors.blue),
      ),
    );
  }

  Widget _buildAlreadyRegisterDevice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),
        Text(
          context.t.register.screenDividerAlreadyRegister,
          style: AppTextStyle.bodyXSmall,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormFieldPassword() {
    return TextFieldWidget(
      controller: _passwordRegisterController,
      hintText: context.t.register.screenFormFieldPasswordHintText,
      name: context.t.register.screenFormFieldPasswordName,
      obscureText: true,
    );
  }

  Widget _buildTextFormFieldEmail() {
    return TextFieldWidget(
      controller: _emailRegisterController,
      hintText: context.t.register.screenFormFieldEmailHintText,
      name: context.t.register.screenFormFieldEmailName,
      emailAddress: TextInputType.emailAddress,
    );
  }

  Widget _buildRequireField() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.darkRed,
          ),
          child: Text(
            context.t.register.screenRequiredHeading,
            style: AppTextStyle.whiteBodyXSmall,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          context.t.register.screenRequiredContent,
          style: AppTextStyle.darkGreyBodyXXSmall,
        ),
      ],
    );
  }

  Widget _buildButtonSendAuthentication(
    BuildContext context,
    RegisterViewModel viewModel,
  ) {
    return CommonButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.register(
            email: _emailRegisterController.text,
            password: _passwordRegisterController.text,
            onSuccess: () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.verifyEmailRegister,
                  (route) => false,
                );
              });
            },
            onError: (message) {
              Utils.showErrorDialog(
                message: message.toLowerCase().replaceAll('_', ' '),
              );
            },
          );
        }
      },
      title: context.t.register.screenButtonName,
      buttonType: ButtonType.warning,
      leadingIcon: const Icon(
        Icons.mail_rounded,
        color: AppColors.black,
      ),
    );
  }
}
