import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';

class ListMedicalTreatmentsItem extends StatefulWidget {
  const ListMedicalTreatmentsItem({
    super.key,
    required this.medicalTreatment,
  });

  final MedicalTreatment medicalTreatment;

  @override
  State<ListMedicalTreatmentsItem> createState() =>
      _ListMedicalTreatmentsItemState();
}

class _ListMedicalTreatmentsItemState extends State<ListMedicalTreatmentsItem> {
  late Color dominantColor = _getDominantColorFromSvg() ?? AppColors.cyan;

  Color? _getDominantColorFromSvg() {
    RegExp colorRegex = RegExp(r'fill="(.*?)"');
    Match? matche = colorRegex.firstMatch(widget.medicalTreatment.icon);
    String? textDominantColor =
        matche?.group(1)?.replaceAll('rgb(', '').replaceAll(')', '');
    if (textDominantColor == null) return null;
    List<String> rgbValues = textDominantColor.split(',');
    int r = int.parse(rgbValues[0].trim());
    int g = int.parse(rgbValues[1].trim());
    int b = int.parse(rgbValues[2].trim());
    return Color.fromRGBO(r, g, b, 1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.appointment,
          arguments: {'medicalTreatment': widget.medicalTreatment},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: dominantColor),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dominantColor.withOpacity(.2),
                ),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.string(widget.medicalTreatment.icon),
                ),
              ),
              Expanded(
                child: Text(widget.medicalTreatment.name),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
