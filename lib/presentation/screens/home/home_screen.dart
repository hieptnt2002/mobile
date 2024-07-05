import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_svg.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/home/home_view_model.dart';
import 'package:make_appointment_app/presentation/screens/home/widgets/home_carousel_slider.dart';
import 'package:make_appointment_app/presentation/screens/home/widgets/list_medical_treatments_item.dart';
import 'package:make_appointment_app/presentation/screens/widgets/app_drawer.dart';
import 'package:make_appointment_app/presentation/screens/home/widgets/home_sliver_app_bar.dart';
import 'package:make_appointment_app/presentation/screens/widgets/app_drawer_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCyan,
      endDrawer: ChangeNotifierProvider.value(
        value: context.read<HomeViewModel>(),
        child: ChangeNotifierProvider(
          create: (context) => AppDrawerViewModel(),
          child: const AppDrawer(),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final medicalTreatmentList = viewModel.medicalTreatmentList;
          return CustomScrollView(
            slivers: [
              const HomeSliverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.cyan,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const HomeCarouselSlider(),
                      _buildSubBanner(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        context.t.home.medicalTreatmentsTitle,
                        style: AppTextStyle.headingSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        context.t.home.medicalTreatmentsSubtitle,
                        style: AppTextStyle.cyanLabelMedium,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              _buildListMedicalTreatments(medicalTreatmentList),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListMedicalTreatments(
    List<MedicalTreatment> medicalTreatmentList,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListMedicalTreatmentsItem(
              medicalTreatment: medicalTreatmentList[index],
            );
          },
          childCount: medicalTreatmentList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 90,
        ),
      ),
    );
  }

  Widget _buildSubBanner() {
    return Container(
      margin: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.network(
                  width: 60,
                  'https://clinic.dmm.com/img/pc/top/pic_illust_mv.svg?id=c24d7cc00737f5892b40',
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.t.home.onlineMedicalConsultation,
                        style: AppTextStyle.labelXSmall,
                      ),
                      Text(
                        context.t.home.receptionTime,
                        style: AppTextStyle.headingXSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: AppColors.darkGray,
            width: 1,
            height: 80,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppSvg.clock, width: 24),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        context.t.home.hourService,
                        style: AppTextStyle.cyanLabelMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  context.t.home.excludingTheNewYearHolidays,
                  style: AppTextStyle.darkGrayBodyXSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
