import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isDestructive ? const Color(0xFFDB3F3F) : const Color(0xFF231F20);

    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 25.w, color: iconColor),
          SizedBox(width: 10.w),
          Container(
            width: 275.w,
            height: 50.h,
            padding: EdgeInsets.only(bottom: 5.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: const Color(0xFFE5E5E5),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: AppTextStyle.protileItem),
                Icon(Icons.arrow_forward_ios_rounded, size: 16.w, color: iconColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
