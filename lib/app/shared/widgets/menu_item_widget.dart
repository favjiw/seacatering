import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final int price;
  final VoidCallback onViewMore;

  const MenuItemWidget({
    super.key,
    required this.title,
    required this.price,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyle.menuTitle),
              Text('Rp${price.toString()}', style: AppTextStyle.menuTitle),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: 327.w,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.gray,
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: onViewMore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black.withOpacity(0.2),
                  elevation: 0,
                ),
                child: Text('View More', style: AppTextStyle.body),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: 330.w,
            height: 1.h,
            color: AppColors.gray.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
