import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class StageRegisterWidget extends StatelessWidget {
  final int step;

  const StageRegisterWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final multiLanguage = context.t.register;
    final double widthScreen = MediaQuery.of(context).size.width;
    TextStyle colorText1 = AppTextStyle.w600Black12px;
    TextStyle colorText2 = AppTextStyle.w600Black12px;
    TextStyle colorText3 = AppTextStyle.w600Black12px;
    double widthStraight = 0;
    double widthCircular = 0;

    switch (step) {
      case 1:
        {
          colorText1 = AppTextStyle.w600Blue12px;
          widthStraight = widthScreen * 0.15;
          widthCircular = widthScreen * 0.12;
        }

      case 2:
        {
          colorText1 = AppTextStyle.w600Black12px;
          colorText2 = AppTextStyle.w600Blue12px;
          widthStraight = widthScreen * 0.46;
          widthCircular = widthScreen * 0.43;
        }

      case 3:
        {
          colorText1 = AppTextStyle.w600Black12px;
          colorText2 = AppTextStyle.w600Black12px;
          colorText3 = AppTextStyle.w600Blue12px;
          widthStraight = widthScreen * 0.90;
          widthCircular = widthScreen * 0.88;
        }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                multiLanguage.stageRegisterWidgetRegister,
                style: colorText1,
              ), //colorActived blackHeadingXXXSmall
              Text(
                multiLanguage.stageRegisterWidgetAuthentication,
                style: colorText2,
              ), //colorIsactive
              Text(
                multiLanguage.stageRegisterWidgetComplete,
                style: colorText3,
              ) //colorFinish blackBodyXXSmall
              ,
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Stack(
                  children: [
                    Container(
                      width: widthScreen,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      width: widthStraight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: widthCircular),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
