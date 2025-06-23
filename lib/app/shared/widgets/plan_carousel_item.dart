import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

class PlanCarouselItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;
  final String badgeImagePath;
  final double rightPadding;

  const PlanCarouselItem({
    super.key,
    required this.isActive,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
    required this.badgeImagePath,
    this.rightPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w),
      child: Row(
        children: [
          SizedBox(width: 27.w,),
          SizedBox(
                width: isActive ? 205.w : 160.w,
                height: isActive ? 245.h : 190.h,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isActive ? 200.w : 160.w,
                        height: isActive ? 195.h : 154.h,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.containerHomeActive
                              : AppColors.containerHomeInactive,
                          borderRadius: BorderRadius.circular(isActive ? 25.r : 20.r),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15.w),
                                  child: Image.asset(
                                    badgeImagePath,
                                    width: isActive ? 30.w : 23.w,
                                    height: isActive ? 30.h : 23.h,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          title,
                                          style: isActive
                                              ? AppTextStyle.planTitleActive
                                              : AppTextStyle.planTitleInactive,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          subtitle,
                                          style: isActive
                                              ? AppTextStyle.plansSubtitleActive
                                              : AppTextStyle.plansSubtitleInactive,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          price,
                                          style: isActive
                                              ? AppTextStyle.planTitleActive
                                              : AppTextStyle.planTitleInactive,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      top: isActive ? 0 : 30,
                      left: isActive ? 40 : 45,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isActive ? 120.w : 79.w,
                        height: isActive ? 120.h : 79.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            alignment: Alignment.centerRight,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
        ],
      ),
    );
  }
}