import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String imageCircle;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.imageCircle,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageCircle, width: 1.sw),
          SizedBox(height: 15.h),
          Image.asset(image, height: 200.h),
          SizedBox(height: 40.h),
          Text(
            title,
            style: AppTextStyle.onboardTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 334.w,
            child: Text(
              description,
              style: AppTextStyle.onboardDesc,
              textAlign: TextAlign.center,
            ),
          ),
        ],
    );
  }
}
