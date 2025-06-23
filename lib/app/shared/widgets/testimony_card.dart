import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

class TestimonialCard extends StatelessWidget {
  final String content;
  final String userName;
  final String planName;
  final int rating;
  final String? avatarUrl;

  const TestimonialCard({
    super.key,
    required this.content,
    required this.userName,
    required this.planName,
    required this.rating,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195.w,
      // height: 210.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.gray.withOpacity(0.4),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star_rounded,
                color: index < rating ? AppColors.yellowTitle : AppColors.gray,
                size: 30.sp,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          // Konten testimoni
          SizedBox(
            height: 85.h,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Text(
                content,
                style: AppTextStyle.testimonyTitle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Divider
          Container(
            width: 163.w,
            height: 1.h,
            color: AppColors.gray.withOpacity(0.2),
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(100.r),
                  image:
                      avatarUrl != null
                          ? DecorationImage(
                            image: NetworkImage(avatarUrl!),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      userName,
                      style: AppTextStyle.testimonyUsername,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(planName, style: AppTextStyle.testimonyPlan),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
