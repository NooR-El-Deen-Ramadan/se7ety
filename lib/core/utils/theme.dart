import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/fonts.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundColor,
    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppFontStyles.headLine.copyWith(
        color: AppColors.blackColor,
      ),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      surfaceTintColor: Colors.transparent,
    ),

    //snackbar theme
    snackBarTheme: SnackBarThemeData(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.primaryColor,
    ),

    //font theme
    fontFamily: Fonts.cairo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),

    //datepicker theme
    datePickerTheme: DatePickerThemeData(
      headerForegroundColor: AppColors.primaryColor,
      backgroundColor: AppColors.whiteColor,
      subHeaderForegroundColor: AppColors.blackColor,
    ),

    //timepicker theme
    timePickerTheme: TimePickerThemeData(
      dayPeriodColor: AppColors.greyColor,
      dayPeriodTextColor: AppColors.primaryColor,
      hourMinuteTextColor: AppColors.whiteColor,
      hourMinuteColor: AppColors.darkColor,
      dialBackgroundColor: AppColors.primaryColor,
      backgroundColor: AppColors.whiteColor,
    ),
    //buttomNavigation bar decoration
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor: AppColors.primaryColor,
    ),

    //text buttom theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(5),
        shadowColor: Colors.transparent,
        foregroundColor: AppColors.darkColor,
      ),
    ),
    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardColor.withValues(alpha: 0.3),
      prefixIconColor: AppColors.primaryColor,
      suffixIconColor: AppColors.primaryColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
  );
}
