import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onViewMore;
  final String image;

  const MenuItemWidget({
    super.key,
    required this.title,
    required this.price,
    required this.onViewMore,
    this.image = '',
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
              Text('${price}', style: AppTextStyle.menuTitle),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  image,
                  width: 327.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 327.w,
                      height: 200.h,
                      child: Image.asset(
                        'assets/images/protein.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      width: 327.w,
                      height: 200.h,
                      child: Image.asset(
                        'assets/images/protein.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: onViewMore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black.withOpacity(0.5),
                    elevation: 0,
                  ),
                  child: Text('View More', style: AppTextStyle.whiteOnBtn),
                ),
              ],
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
