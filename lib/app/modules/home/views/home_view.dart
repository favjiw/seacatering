import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/plan_carousel_item.dart';
import '../../../shared/widgets/testimony_card.dart';
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            ],
                          ),
                          Obx(()=> SizedBox(
                              width: 223.w,
                              child: Text(controller.address.value, style: AppTextStyle.homeLoc, overflow: TextOverflow.ellipsis,)),),
                        ],
                      ),
                      InkWell(
                        onTap: () => Get.toNamed('/profile'),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 25.r,
                          child: Icon(Icons.person_rounded, color: AppColors.white, size: 30.r,),
                        ),
                      ),
                    ],
                  ),
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
                              'Delivered to ',
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
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h,),
                  Text('Popular Plans', style: AppTextStyle.homeTitle,),
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoadingPlans.value) {
                return SizedBox(
                  height: 255.h,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.plans.isEmpty) {
                return SizedBox(
                  height: 255.h,
                  child: Center(child: Text('No plans available')),
                );
              }

              return SizedBox(
                height: 255.h,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.plans.length,
                  pageSnapping: true,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    final plan = controller.plans[index];
                    return Obx(() {
                      final currentActive = index == controller.currentPlanIndex.value;
                      return PlanCarouselItem(
                        isActive: currentActive,
                        plan: plan,
                      );
                    });
                  },
                ),
              );
            }),
            SizedBox(height: 14.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Testimony', style: AppTextStyle.homeTitle),
                ],
              ),
            ),
            SizedBox(height: 14.h,),
            Obx(() {
              if (controller.isLoadingTestimonies.value) {
                return SizedBox(
                  height: 210.h,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.testimonies.isEmpty) {
                return SizedBox(
                  height: 210.h,
                  child: Center(child: Text('No testimonials available')),
                );
              }
              return SizedBox(
                height: 210.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.testimonies.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final testimony = controller.testimonies[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w, left: index == 0 ? 27.w : 0),
                      child: TestimonialCard(
                        content: testimony.content,
                        userName: testimony.userName,
                        planName: testimony.planName,
                        rating: testimony.rating.toInt(),
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: 100.h,),
          ],
        ),
      ),
    );
  }
}
