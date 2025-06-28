import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/testimony_controller.dart';

class TestimonyView extends GetView<TestimonyController> {
  const TestimonyView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          title: Text('Testimony'),
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
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Text("Name", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  CustomTextField(
                    width: 344.w,
                    height: 56.h,
                    controller: controller.nameController,
                    hintText: "Your name",
                    hintStyle: AppTextStyle.hintStyle,
                    inputStyle: AppTextStyle.inputStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Text("Review Message", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  CustomTextField(
                    width: 344.w,
                    height: 200.h,
                    maxLine: 5,
                    controller: controller.messageController,
                    hintText: "Review Message",
                    hintStyle: AppTextStyle.hintStyle,
                    inputStyle: AppTextStyle.inputStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please leave a message';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Text("Rating", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  Center(
                    child: Obx(
                          () => RatingBar.builder(
                        initialRating: controller.rating.value, // Tambahkan .value di sini
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 40,
                        itemBuilder: (context, _) => Icon(Icons.star_rounded, color: Colors.amber),
                        onRatingUpdate: (rating) => controller.rating.value = rating, // Tetap gunakan .value
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 49.w, vertical: 15.h),
          child: CustomButton(
            text: "Send a Testimony",
            onPressed: () {
              // Validasi form
              final isFormValid = controller.formKey.currentState?.validate() ?? false;
              if (!isFormValid) {
                Get.snackbar("Error", "Harap lengkapi semua field");
                return;
              }
              controller.submitTestimony();
            },
          ),
        ),
      ),
    );
  }
}
