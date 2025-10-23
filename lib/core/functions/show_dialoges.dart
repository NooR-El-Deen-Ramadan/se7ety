import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/animation.dart';
import 'package:se7ety/core/utils/colors.dart';

enum DialogTypes { error, success, warning }

void showDialoges({
  required BuildContext context,
  required String message,
  DialogTypes type = DialogTypes.error,
}) {
  Color backgroundColor;

  switch (type) {
    case DialogTypes.success:
      backgroundColor = AppColors.primaryColor;
      break;
    case DialogTypes.error:
      backgroundColor = Colors.red;
      break;
    case DialogTypes.warning:
      backgroundColor = Colors.yellow;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(20),
      content: Text(message),
    ),
  );
}

void showLoadingDialog({required BuildContext context}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Center(child: Lottie.asset(AppAnimation.loadingAnimation));
    },
  );
}
