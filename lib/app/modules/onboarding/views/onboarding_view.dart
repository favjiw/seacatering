import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/widgets/onboarding_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';
import 'package:seacatering/app/shared/widgets/custom_button.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndex,
              children: [
                OnboardingPage(
                  imageCircle: 'assets/images/onboard-ellipse-1.png',
                  image: 'assets/images/onboard-1.png',
                  title: 'Personalized Meal Plans',
                  description: 'Choose a plan that fits your lifestyle.',
                ),
                OnboardingPage(
                  imageCircle: 'assets/images/onboard-ellipse-2.png',
                  image: 'assets/images/onboard-2.png',
                  title: 'Track Your Progress',
                  description:
                      'Monitor your nutritional intake and meal history to stay on track with your goals.',
                ),
                OnboardingPage(
                  imageCircle: 'assets/images/onboard-ellipse-3.png',
                  image: 'assets/images/onboard-3.png',
                  title: 'Enjoy Your Meal Time',
                  description: 'Delivered fresh to your doorstep',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.h),
            child: SizedBox(
              height: 200.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10.h,
                      dotWidth: 10.h,
                      spacing: 8.w,
                      dotColor: Colors.grey.shade300,
                      activeDotColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Obx(
                    () =>
                        controller.pageIndex.value == 2
                            ? Center(
                              child: CustomButton(
                                width: 200.w,
                                borderRadius: 4.r,
                                backgroundColor: AppColors.primary,
                                textStyle: AppTextStyle.whiteOnBtn,
                                text: 'Start',
                                onPressed: () => Get.offAllNamed('/login'),
                              ),
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => Get.offAllNamed('/login'),
                                  child: Text(
                                    'Skip',
                                    style: AppTextStyle.primaryBtn,
                                  ),
                                ),
                                CustomButton(
                                  width: 120.w,
                                  borderRadius: 4.r,
                                  backgroundColor: AppColors.primary,
                                  textStyle: AppTextStyle.whiteOnBtn,
                                  text: 'Next',
                                  onPressed: () {
                                    controller.nextPage();
                                  },
                                ),
                              ],
                            ),
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
