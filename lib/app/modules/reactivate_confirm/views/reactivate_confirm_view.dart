import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../controllers/reactivate_confirm_controller.dart';

class ReactivateConfirmView extends GetView<ReactivateConfirmController> {
  const ReactivateConfirmView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Confirm Reactivation'),
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
            children: [
              SizedBox(height: 20.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                width: 328.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.r),
                  border: Border.all(
                    color: HexColor('#C6C6C6'),
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Information", style: AppTextStyle.confTitle,),
                    SizedBox(height: 10.h,),
                    Text("Full Name:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.name, style: AppTextStyle.confVal,),
                    SizedBox(height: 20.h,),
                    Text("Phone Number:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.phone, style: AppTextStyle.confVal,),
                    SizedBox(height: 15.h,),
                    Container(
                      width: 289.w,
                      height: 1.h,
                      color: AppColors.gray,
                    ),
                    SizedBox(height: 20.h),
                    Text("Subscription Plan", style: AppTextStyle.confTitle,),
                    SizedBox(height: 10.h,),
                    Text("Menu Name:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.selectedPlan, style: AppTextStyle.confVal,),
                    SizedBox(height: 20.h,),
                    Text("Meal Type:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.selectedMeals.join(', '), style: AppTextStyle.confVal,),
                    SizedBox(height: 20.h,),
                    Text("Delivery Days:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.selectedDeliveryDays.join(', '), style: AppTextStyle.confVal,),
                    SizedBox(height: 20.h,),
                    Text("Allergies:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.allergies.isEmpty ? "No allergies" : controller.data.allergies, style: AppTextStyle.confVal,),
                    SizedBox(height: 20.h,),
                    Text("Note:", style: AppTextStyle.confLabel,),
                    SizedBox(height: 10.h,),
                    Text(controller.data.additionalRequest.isEmpty ? "No note" : controller.data.additionalRequest, style: AppTextStyle.confVal,),
                    SizedBox(height: 20.h,),
                    Container(
                      width: 289.w,
                      height: 1.h,
                      color: AppColors.gray,
                    ),
                    SizedBox(height: 20.h),
                    Text("Payment", style: AppTextStyle.confTitle,),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${controller.data.selectedPlan}", style: AppTextStyle.confVal,),
                        Text("${controller.formattedMeal.toString()}", style: AppTextStyle.confVal,),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Meal Type (${controller.data.selectedMeals.length})", style: AppTextStyle.confVal,),
                        Text("x${controller.data.selectedMeals.length}", style: AppTextStyle.confVal,),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Days (${controller.data.selectedDeliveryDays.length})", style: AppTextStyle.confVal,),
                        Text("x${controller.data.selectedDeliveryDays.length}", style: AppTextStyle.confVal,),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Week", style: AppTextStyle.confVal,),
                        Text("x${controller.feePerDelivery}", style: AppTextStyle.confVal,),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: AppTextStyle.confVal,),
                        Text("${controller.formattedTotal}", style: AppTextStyle.confVal,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h,),
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
          text: controller.isUpdating.value ? "Processing..." : "Confirm Reactivation",
          onPressed: controller.isUpdating.value
              ? null
              : () => controller.reactivateExistingSubscription(),
        )
      ),
    );
  }
}
