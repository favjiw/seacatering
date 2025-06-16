import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seacatering/app/shared/constants/colors.dart';

class AppTextStyle {
  static final splash = GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final body = GoogleFonts.roboto(
    fontSize: 14.sp,
    color: Colors.grey[800],
  );

  static final caption = GoogleFonts.openSans(
    fontSize: 12.sp,
    color: Colors.grey,
  );
}
