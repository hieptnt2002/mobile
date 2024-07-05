import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_svg.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

enum GenderSpecificTreatmentType { male, female }

class GenderSpecificTreatmentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final GenderSpecificTreatmentType gender;
  const GenderSpecificTreatmentButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          overlayColor: const MaterialStatePropertyAll(AppColors.lightNavy),
          child: Container(
            height: 45,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: _getBorderColor()),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 97, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: _getTitleStyle(),
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: _getIconColor(),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, bottom: 2),
          child: SvgPicture.asset(
            _getImagePath(),
            width: 64,
            height: 59,
          ),
        ),
      ],
    );
  }

  String _getImagePath() {
    switch (gender) {
      case GenderSpecificTreatmentType.male:
        return AppSvg.picDoctorMale;
      case GenderSpecificTreatmentType.female:
        return AppSvg.picDoctorFemale;
    }
  }

  TextStyle _getTitleStyle() {
    switch (gender) {
      case GenderSpecificTreatmentType.male:
        return AppTextStyle.w700DarkNavy14Px;
      case GenderSpecificTreatmentType.female:
        return AppTextStyle.w700Red14Px;
    }
  }

  Color _getIconColor() {
    switch (gender) {
      case GenderSpecificTreatmentType.male:
        return AppColors.darkNavy;
      case GenderSpecificTreatmentType.female:
        return AppColors.red;
    }
  }

  Color _getBorderColor() {
    switch (gender) {
      case GenderSpecificTreatmentType.male:
        return AppColors.darkNavy;
      case GenderSpecificTreatmentType.female:
        return AppColors.darkRed;
    }
  }
}
