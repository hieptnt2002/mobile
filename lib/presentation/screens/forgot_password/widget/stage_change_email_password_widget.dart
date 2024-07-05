import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class StageChangeEmailPasswordWidget extends StatelessWidget {
  final int step;

  const StageChangeEmailPasswordWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    var line2 = AppColors.gray;
    var line3 = AppColors.gray;
    var backGround1 = AppColors.white;
    var backGround2 = AppColors.white;
    var backGround3 = AppColors.white;
    var text1 = AppColors.black;
    var text2 = AppColors.black;
    var text3 = AppColors.black;
    var border1 = AppColors.gray;
    var border2 = AppColors.gray;
    var border3 = AppColors.gray;
    final multiLanguage = context.t.forgotPassword;

    switch (step) {
      case 1: // Verify Stage
        {
          backGround1 = AppColors.blue;
          text1 = AppColors.white;
          border1 = AppColors.transparent;
        }
      case 2: // Change password Stage
        {
          backGround1 = AppColors.blue;
          backGround2 = AppColors.blue;
          text1 = AppColors.white;
          text2 = AppColors.white;
          border1 = AppColors.transparent;
          border2 = AppColors.transparent;
          line2 = AppColors.blue;
        }
      case 3: // Complete
        {
          backGround1 = AppColors.blue;
          backGround2 = AppColors.blue;
          backGround3 = AppColors.blue;
          text1 = AppColors.white;
          text2 = AppColors.white;
          text3 = AppColors.white;
          border1 = AppColors.transparent;
          border2 = AppColors.transparent;
          border3 = AppColors.transparent;
          line2 = AppColors.blue;
          line3 = AppColors.blue;
        }
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widthScreen * 0.3,
              height: 20,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: line2,
                  ),
                ),
              ),
            ),
            Container(
              width: widthScreen * 0.3,
              height: 20,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: line3,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCircular(
                colorBackground: backGround1,
                colorText: text1,
                numberStage: '1',
                colorBorder: border1,
                nameStage: multiLanguage.stageChangePasswordWidgetVerify,
              ),
              buildCircular(
                colorBackground: backGround2,
                colorText: text2,
                numberStage: '2',
                colorBorder: border2,
                nameStage: multiLanguage.stageChangePasswordWidgetChange,
              ),
              buildCircular(
                colorBackground: backGround3,
                colorText: text3,
                numberStage: '3',
                colorBorder: border3,
                nameStage: multiLanguage.stageChangePasswordWidgetComplete,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCircular({
    required Color? colorBackground,
    required Color? colorBorder,
    required Color? colorText,
    required String numberStage,
    required String? nameStage,
  }) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: colorBorder!,
            ),
          ),
          child: Text(
            numberStage,
            style: TextStyle(color: colorText),
          ),
        ),
        Text(
          nameStage!,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
