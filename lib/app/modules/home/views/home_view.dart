import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/plan_carousel_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, color: AppColors.black),
                          SizedBox(width: 5.w),
                          Text('Send to', style: AppTextStyle.body,),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person_rounded, color: AppColors.black),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 223.w,
                      child: Text('Moh Toha, Bandung', style: AppTextStyle.homeLoc, overflow: TextOverflow.ellipsis,)),
                  SizedBox(height: 14.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    width: 327.w,
                    // height: 192.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24.r),
                      image: DecorationImage(
                        image: AssetImage("assets/images/hero-container-img.png"),
                        alignment: Alignment.centerRight,
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 18.h),
                        Text(
                          'Delicious. Healthy.',
                          style: AppTextStyle.heroTitleWhite,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Delivired to ',
                              style: AppTextStyle.heroTitleWhite,
                            ),
                            Text('You,', style: AppTextStyle.heroTitleYellow),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          "Personalized meal plans \nmade for your \nlifestyle.",
                          style: AppTextStyle.heroSubtitle,
                        ),
                        SizedBox(height: 14.h),
                        CustomButton(
                          width: 114.w,
                          height: 40.h,
                          text: 'See our menu',
                          textStyle: AppTextStyle.heroBtn,
                          backgroundColor: AppColors.white,
                          borderRadius: 10.r,
                          horizontalPad: 0,
                          verticalPad: 0,
                          elevation: 0,
                          onPressed: () {
                            // Get.toNamed('/menu');
                          },
                        ),
                        SizedBox(height: 18.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text('Your Subscription', style: AppTextStyle.homeTitle,),
                  SizedBox(height: 10.h),
                  Container(
                    width: 100.w,
                    height: 100.h,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 14.h,),
                  Text('Popular Plans', style: AppTextStyle.homeTitle,),

                ],
              ),
            ),
            SizedBox(
                height: 255.h,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.plans.length,
                  pageSnapping: true,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    final plan = controller.plans[index];
                    // Handle empty item (index 3)
                    if (index == 3) return const SizedBox.shrink();
                    final isActive = index == controller.currentPlanIndex.value;
                    return Obx(() {
                      final currentActive = index == controller.currentPlanIndex.value;
                      return PlanCarouselItem(
                            isActive: currentActive,
                            title: plan.title,
                            subtitle: plan.subtitle,
                            price: plan.price,
                            imagePath: plan.imagePath,
                            badgeImagePath: plan.badgeImagePath,
                      );
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
