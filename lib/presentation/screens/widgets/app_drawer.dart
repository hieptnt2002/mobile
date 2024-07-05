import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/home/home_view_model.dart';
import 'package:make_appointment_app/presentation/screens/widgets/app_drawer_view_model.dart';
import 'package:make_appointment_app/presentation/screens/widgets/gender_specific_treatment_button.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  late final _viewModel = context.read<AppDrawerViewModel>();
  late final Animation<double> _animationTurns;
  late final AnimationController _animationController;
  bool isTreatmentDetailsVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationTurns = Tween(begin: 0.0, end: 0.5).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _toggleRotation() {
    setState(() {
      if (_animationController.isDismissed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      isTreatmentDetailsVisible = !isTreatmentDetailsVisible;
    });
  }

  void _pushToScreen(String route) {
    Scaffold.of(context).closeEndDrawer();
    if (route != Routes.home) {
      Navigator.pushNamed(context, route);
    } else if (ModalRoute.of(context)?.settings.name != Routes.home &&
        ModalRoute.of(context)?.settings.name != '/') {
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GenderSpecificTreatmentButton(
              onPressed: () {},
              title: context.t.drawer.forMen,
              gender: GenderSpecificTreatmentType.male,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GenderSpecificTreatmentButton(
              onPressed: () {},
              title: context.t.drawer.forWomen,
              gender: GenderSpecificTreatmentType.female,
            ),
          ),
          const SizedBox(height: 10),
          _buildContent(
            content: context.t.drawer.top,
            onPressed: () {
              _pushToScreen(Routes.home);
            },
          ),
          _buildExpandableTreatmentDetails(),
          if (isTreatmentDetailsVisible) _buildTreatmentDetails(),
          _buildContent(
            content: context.t.drawer.whatIsOnlineClinic,
            onPressed: () {},
          ),
          _buildContent(
            content: context.t.drawer.howToUser,
            onPressed: () => _pushToScreen(Routes.serviceInstructions),
          ),
          _buildContent(
            content: context.t.drawer.faq,
            onPressed: () {},
          ),
          _buildContent(
            content: context.t.drawer.doctorColumn,
            onPressed: () {
              _pushToScreen(Routes.post);
            },
          ),
          _buildSwitchLanguage(),
          const Divider(thickness: 1, color: AppColors.lightGray),
          _buildContent(
            content: _viewModel.isLoggedIn
                ? context.t.drawer.logout
                : context.t.drawer.loginOrRegister,
            onPressed: () {
              if (_viewModel.isLoggedIn) {
                _viewModel.logOut();
                _pushToScreen(Routes.home);
              } else {
                _pushToScreen(Routes.login);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableTreatmentDetails() {
    return InkWell(
      onTap: () {
        _toggleRotation();
      },
      overlayColor: const MaterialStatePropertyAll(AppColors.lightNavy),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              context.t.drawer.treatmentDetails,
              style: AppTextStyle.w700TextColor16Px,
            ),
            const SizedBox(width: 4),
            RotationTransition(
              turns: _animationTurns,
              child: const Icon(Icons.keyboard_arrow_up_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentDetails() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (_, index) {
        final medicalTreatment = _viewModel.medicalTreatments[index];
        return _buildTreatmentDetailItem(medicalTreatment);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _viewModel.medicalTreatments.length,
    );
  }

  Widget _buildSwitchLanguage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Consumer<AppDrawerViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'English / Japanese',
                  style: AppTextStyle.w700TextColor16Px,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Switch(
                activeColor: AppColors.cyan,
                value: viewModel.currentLocale == 'ja',
                onChanged: (bool value) {
                  final locale = value ? 'ja' : 'en';
                  viewModel.updateLocale(locale).then((_) async {
                    await context
                        .read<HomeViewModel>()
                        .getMedicalTreatmentList();
                    setState(() {});
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent({required String content, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      overlayColor: const MaterialStatePropertyAll(AppColors.lightNavy),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          content,
          style: AppTextStyle.w700TextColor16Px,
        ),
      ),
    );
  }

  Widget _buildTreatmentDetailItem(MedicalTreatment medicalTreatment) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.appointment,
          arguments: {'medicalTreatment': medicalTreatment},
        );
      },
      overlayColor: const MaterialStatePropertyAll(AppColors.lightNavy),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 32, bottom: 10, right: 20),
        child: Text(
          medicalTreatment.name,
          style: AppTextStyle.bodySmall,
        ),
      ),
    );
  }
}
