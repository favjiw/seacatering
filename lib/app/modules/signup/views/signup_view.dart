import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';
import 'package:seacatering/app/shared/widgets/custom_button.dart';

import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        //appnar with back button
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text('Sign up', style: AppTextStyle.signTitle),
                SizedBox(height: 18.h),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hintText: 'Full name',
                        controller: controller.usernameController,
                        inputStyle: AppTextStyle.inputStyle,
                        hintStyle: AppTextStyle.hintStyle,
                        prefixIcon: Icon(
                          Icons.person_rounded,
                          color: AppColors.primary,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h,),
                      CustomTextField(
                        hintText: 'user@gmail.com',
                        controller: controller.emailController,
                        inputStyle: AppTextStyle.inputStyle,
                        hintStyle: AppTextStyle.hintStyle,
                        prefixIcon: Icon(Icons.email_rounded, color: AppColors.primary,),
                        //validate using emailvalidator
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h,),
                      Obx(() => CustomTextField(
                        hintText: 'Your password',
                        controller: controller.passwordController,
                        obscureText: controller.isObscure.value,
                        inputStyle: AppTextStyle.inputStyle,
                        hintStyle: AppTextStyle.hintStyle,
                        prefixIcon: Icon(Icons.lock_rounded, color: AppColors.primary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isObscure.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                                color: AppColors.primary,
                          ),
                          onPressed: controller.toggle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),),
                      SizedBox(height: 20.h,),
                      Obx(() => CustomTextField(
                        hintText: 'Confirm password',
                        controller: controller.confirmPasswordController,
                        obscureText: controller.isConfirmObscure.value,
                        inputStyle: AppTextStyle.inputStyle,
                        hintStyle: AppTextStyle.hintStyle,
                        prefixIcon: Icon(Icons.lock_rounded, color: AppColors.primary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmObscure.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: AppColors.primary,
                          ),
                          onPressed: controller.toggleConfirm,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),),
                      SizedBox(height: 50.h,),
                      Center(
                        child: CustomButton(
                          width: 271.w,
                          height: 60.h,
                          text: 'Sign up',
                          textStyle: AppTextStyle.whiteOnBtn,
                          backgroundColor: AppColors.primary,
                          borderRadius: 15.r,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              // controller.signUp();
                            }
                          },
                        ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: AppTextStyle.body),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Sign in', style: AppTextStyle.textBtn),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
