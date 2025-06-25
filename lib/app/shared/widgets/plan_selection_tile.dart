import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

class PlanSelectionTile extends StatelessWidget {
  final String title;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanSelectionTile({
    super.key,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 17.h),
          width: 334.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(
              color: isSelected ? AppColors.black : AppColors.gray,
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.subsSelectedPlan),
                  Text(price, style: AppTextStyle.subsUnselectedPlan),
                ],
              ),
              Image.asset(
                isSelected
                    ? 'assets/images/selected-radio-circle.png'
                    : 'assets/images/unselected-radio-circle.png',
                width: 20.w,
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
