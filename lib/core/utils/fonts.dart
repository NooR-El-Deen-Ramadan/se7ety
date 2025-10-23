import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';

class AppFontStyles {
  static TextStyle headLine=const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );

   static TextStyle title=const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );

   static TextStyle body=const TextStyle(
    fontSize: 16,
    color: AppColors.darkColor,
  );

   static TextStyle small=const TextStyle(
    fontSize: 12,
    color: AppColors.greyColor,
  );
}
