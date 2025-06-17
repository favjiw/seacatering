import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
