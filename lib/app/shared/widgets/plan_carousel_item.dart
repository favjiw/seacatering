import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/PlanModel.dart';
import '../constants/colors.dart';
import '../constants/text_style.dart';

class PlanCarouselItem extends StatelessWidget {
  final bool isActive;
  final PlanModel plan;
  final double rightPadding;

  const PlanCarouselItem({
    super.key,
    required this.isActive,
    required this.plan,
    this.rightPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w),
      child: Row(
        children: [
          SizedBox(width: 27.w),
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
                        SizedBox(
                          width: isActive ? 30.w : 23.w,
                          height: isActive ? 30.h : 23.h,
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
                                    plan.name,
                                    style: isActive
                                        ? AppTextStyle.planTitleActive
                                        : AppTextStyle.planTitleInactive,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    plan.shortDesc,
                                    style: isActive
                                        ? AppTextStyle.plansSubtitleActive
                                        : AppTextStyle.plansSubtitleInactive,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Rp${plan.price}/meal',
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
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: plan.imageCircleUrl.isEmpty
                          ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                          : Image.network(
                        plan.imageCircleUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.error_outline, color: Colors.grey[400]),
                        ),
                      ),
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