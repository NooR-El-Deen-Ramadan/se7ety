// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/fonts.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonText,
    this.width,
    this.height,
    required this.onPressed,
    this.buttomColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.borderColor,
    this.borderRadius,
  });
  final Color buttomColor;
  final double? borderRadius;
  final Color textColor;
  final Color? borderColor;
  final String buttonText;
  final double? width;
  final double? height;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttomColor,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: AppFontStyles.title.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
