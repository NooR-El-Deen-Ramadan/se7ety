import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/components/buttons/main_button.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/fonts.dart';
import 'package:se7ety/features/intro/onboarding/data/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        actions: [
          if (currentPage != 2)
            TextButton(
              onPressed: () {
                pushAndRemoveUntil(context: context, route: AppRouter.welcome);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("تخطي", style: AppFontStyles.title),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              reverse: true,
              itemCount: onboardingList.length,
              controller: controller,
              itemBuilder: (context, index) => Column(
                children: [
                  Spacer(),
                  SvgPicture.asset(height: 350, onboardingList[index].image),
                  Gap(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        Text(
                          onboardingList[index].title,
                          style: AppFontStyles.headLine.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(20),
                        Text(
                          onboardingList[index].description,
                          textAlign: TextAlign.center,
                          style: AppFontStyles.title.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardingList.length,
                    onDotClicked: (index) => (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: WormEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 10,
                    ),
                  ),
                  Spacer(),
                  if (currentPage == 2)
                    MainButton(
                      height: 45,
                      width: 150,
                      buttonText: "هيا بنا",
                      onPressed: () {
                        pushAndRemoveUntil(
                          context: context,
                          route: AppRouter.welcome,
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
}
