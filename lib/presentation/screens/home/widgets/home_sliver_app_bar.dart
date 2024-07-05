import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/button/common_small_button.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/resources/app_svg.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeSliverAppBar extends StatefulWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  State<HomeSliverAppBar> createState() => _HomeSliverAppBarState();
}

class _HomeSliverAppBarState extends State<HomeSliverAppBar> {
  late final _viewModel = context.read<HomeViewModel>();
  void showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: context.t.home.loginRequired,
          content: context.t.home.loginRequiredContent,
          actions: [
            DialogActionButton(
              onTap: () {
                Navigator.pushNamed(context, Routes.login);
              },
              title: context.t.home.logIn,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      floating: true,
      title: _buildTitle(context),
      bottom: _buildBottom(context),
      actions: [Container()],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.t.home.onlineClinic,
                style: AppTextStyle.headingXSmall,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppSvg.notification),
            ),
            IconButton(
              onPressed: () {
                if (_viewModel.isLoggedIn) {
                  Navigator.pushNamed(context, Routes.profile);
                } else {
                  showLoginRequiredDialog();
                }
              },
              icon: SvgPicture.asset(AppSvg.user),
            ),
            IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: SvgPicture.asset(
                AppSvg.menu,
                colorFilter:
                    const ColorFilter.mode(Colors.cyan, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PreferredSize _buildBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: CommonSmallButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.appointment);
                },
                title: context.t.home.appointments,
                leadingIcon: SvgPicture.asset(AppSvg.editCalendar, width: 14),
                buttonType: ButtonType.primary,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CommonSmallButton(
                onPressed: () {
                  if (_viewModel.isLoggedIn) {
                    Navigator.pushNamed(context, Routes.treatmentList);
                  } else {
                    showLoginRequiredDialog();
                  }
                },
                title: context.t.home.myPage,
                leadingIcon: SvgPicture.asset(AppSvg.person, width: 14),
                buttonType: ButtonType.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
