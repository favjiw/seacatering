import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                width: 327.w,
                // height: 192.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24.r),
                  image: DecorationImage(
                    image:
                        Image.asset(
                          "assets/images/hero-container-img.png",
                        ).image,
                    alignment: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 18.h,),
                    Text('Delicious. Healthy.', style: AppTextStyle.heroTitleWhite,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Delivired to ', style: AppTextStyle.heroTitleWhite,),
                        Text('You,', style: AppTextStyle.heroTitleYellow,),
                      ],
                    ),
                    SizedBox(height: 14.h,),
                    Text("Personalized meal plans \nmade for your \nlifestyle.", style: AppTextStyle.heroSubtitle,),
                    SizedBox(height: 14.h,),
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
                    SizedBox(height: 18.h,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
