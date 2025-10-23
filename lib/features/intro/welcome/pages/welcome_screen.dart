import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/fonts.dart';
import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.splashPNG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          PositionedDirectional(
            top: 100,
            start: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اهلا بيك',
                  style: AppFontStyles.title.copyWith(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(15),
                Text(
                  'سجل واحجز عند دكتورك وانت فالبيت',
                  style: AppFontStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 80,
            start: 25,
            end: 25,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'سجل دلوقتي كــ',
                    style: AppFontStyles.title.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildUserButton(
                    title: 'دكتور',
                    onTap: () {
                      pushWithoutReplacment(
                        context: context,
                        route: AppRouter.login,
                        extra: UserTypeEnum.doctor,
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildUserButton(
                    title: 'مريض',
                    onTap: () {
                      pushWithoutReplacment(
                        context: context,
                        route: AppRouter.login,
                        extra: UserTypeEnum.patient,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildUserButton({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withValues(alpha: .7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: AppFontStyles.title.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
