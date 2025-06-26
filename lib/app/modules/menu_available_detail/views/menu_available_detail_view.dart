import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../controllers/menu_available_detail_controller.dart';

class MenuAvailableDetailView extends GetView<MenuAvailableDetailController> {
  const MenuAvailableDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Menu Detail'),
        centerTitle: true,
        titleTextStyle: AppTextStyle.appBarTitle,
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Container(
                width: 327.w,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(controller.menu.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.menu.name,
                    style: AppTextStyle.homeLoc,
                    ),
                  Text(
                    controller.formatPrice(controller.menu.price),
                    style: AppTextStyle.homeLoc,
                  ),
              ]),
              SizedBox(height: 10.h),
              Text(
                'Description',
                style: AppTextStyle.profileEmail,
              ),
              SizedBox(height: 10.h),
              Text(
                controller.menu.desc,
                style: AppTextStyle.profileEmail,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 49.w, vertical: 15.h),
        width: double.infinity,
        height: 88.h,
        color: AppColors.white,
        child: CustomButton(
          width: 277.w,
          height: 58.h,
          text: "Interested",
          onPressed: () {

          },
        ),
      ),
    );
  }
}
