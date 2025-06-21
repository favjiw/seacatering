import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:seacatering/app/shared/constants/colors.dart';

class AppTextStyle {
  static final splash = GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final whiteOnBtn = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static final primaryBtn = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static final inputStyle = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final hintStyle = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryDark,
  );

  static final signTitle = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static final onboardTitle = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static final onboardDesc = GoogleFonts.poppins(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static final heroBtn = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static final heroTitleWhite = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static final heroTitleYellow = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.yellowTitle,
  );

  static final heroSubtitle = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: HexColor('#E7E7E7'),
  );

  static final body = GoogleFonts.roboto(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static final bodyRegular = GoogleFonts.roboto(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static final textBtn = GoogleFonts.roboto(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static final error = GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static final caption = GoogleFonts.openSans(
    fontSize: 12.sp,
    color: Colors.grey,
  );
}
