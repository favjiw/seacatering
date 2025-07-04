import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;
  final String? errorText;

  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final TextInputType? keyboardType;
  final int? maxLine;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.width,
    this.height,
    this.fontSize,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.errorText,
    this.hintStyle,
    this.inputStyle,
    this.keyboardType,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        maxLines: maxLine,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: inputStyle ?? TextStyle(fontSize: fontSize ?? 14.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey, fontSize: 14.sp),
          errorText: errorText,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 16.w,
              ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: HexColor('#E4DFDF'),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: HexColor('#85B1B4'),
              width: 1.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          errorStyle: AppTextStyle.error,
        ),
      ),
    );
  }
}
