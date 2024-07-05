import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:make_appointment_app/base/data/remote/api.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/components/loading/spin_kit_circle.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';

class Utils {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static bool isShowingLoadingDialog = false;
  static bool isShowingErrorDialog = false;

  static void showErrorDialog({
    String? title,
    String? message,
    VoidCallback? onPress,
  }) {
    if (isShowingErrorDialog) return;
    isShowingErrorDialog = true;
    if (isShowingLoadingDialog) {
      popLoading();
    }
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: _navigatorKey.currentState!.context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: (title ?? '').trim().isEmpty
                  ? context.t.utils.error
                  : title ?? '',
              content: (message ?? '').trim().isEmpty
                  ? context.t.utils.errorHasOccurred
                  : message ?? '',
              actions: [
                DialogActionButton(
                  onTap: () {
                    if (onPress != null) {
                      onPress.call();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  title: context.t.utils.ok,
                ),
              ],
            );
          },
        ).then((value) {
          isShowingErrorDialog = false;
        });
      },
    );
  }

  static void showDialogLoading([double opacity = 0.1]) {
    if (isShowingLoadingDialog) return;
    if (isShowingErrorDialog) {
      popErrorDialog();
    }
    isShowingLoadingDialog = true;
    Future.delayed(Duration.zero, () {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(opacity),
        context: _navigatorKey.currentState!.context,
        builder: (context) {
          return const PopScope(
            canPop: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitCircle(
                  color: Colors.white,
                ),
              ],
            ),
          );
        },
      ).then((value) {
        isShowingLoadingDialog = false;
      }).timeout(
        Api.timeout,
        onTimeout: () {
          popLoading();
        },
      );
    });
  }

  static void showTokenExpiredDialog() {
    if (isShowingErrorDialog) {
      popErrorDialog();
    }
    if (isShowingLoadingDialog) {
      popLoading();
    }
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: _navigatorKey.currentState!.context,
          builder: (BuildContext context) {
            return PopScope(
              canPop: false,
              child: CustomDialog(
                title: context.t.utils.sessionExpired,
                content: context.t.utils.contentSessionExpired,
                actions: [
                  DialogActionButton(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login,
                        (route) => false,
                      );
                    },
                    title: context.t.utils.login,
                  ),
                ],
              ),
            );
          },
        ).then((value) {
          isShowingErrorDialog = false;
        });
      },
    );
  }

  static Future<void> popLoading() async {
    if (isShowingLoadingDialog) {
      isShowingLoadingDialog = false;
      Future.delayed(Duration.zero, () {
        _navigatorKey.currentState?.pop();
      });
    }
  }

  static Future<void> popErrorDialog() async {
    if (isShowingErrorDialog) {
      isShowingErrorDialog = false;
      Future.delayed(Duration.zero, () {
        _navigatorKey.currentState?.pop();
      });
    }
  }

  static String formatDateWithWeekday(DateTime date) {
    return DateFormat(
      'MMMM d, yyyy (EEEE)',
      TranslationProvider.of(_navigatorKey.currentState!.context)
          .flutterLocale
          .languageCode,
    ).format(date);
  }

  static showSnackbar(String content, bool isSuccess) {
    ScaffoldMessenger.of(_navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: AppTextStyle.whiteLabelMedium,
        ),
        backgroundColor: isSuccess ? AppColors.green : AppColors.red,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }
}
