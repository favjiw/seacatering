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
                        keyboardType: TextInputType.emailAddress,
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
                      CustomTextField(
                        hintText: 'Your phone number',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        inputStyle: AppTextStyle.inputStyle,
                        hintStyle: AppTextStyle.hintStyle,
                        prefixIcon: Icon(Icons.phone_rounded, color: AppColors.primary),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 8 || value.length > 15) {
                            return 'Enter a valid phone number (8-15 digits)';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Only numbers are allowed';
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
                            return 'Password cannot be empty';
                          }

                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }

                          // Check each requirement separately
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter (A-Z)';
                          }

                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Password must contain at least one lowercase letter (a-z)';
                          }

                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain at least one number (0-9)';
                          }

                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>\-_]').hasMatch(value)) {
                            return 'Password must contain at least one special character (!@#\$% etc.)';
                          }

                          return null;
                        },
                      )),
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
                      Obx(() => Center(
                        child: SizedBox(
                          width: 271.w,
                          height: 60.h,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.signUp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.isLoading.value
                                  ? AppColors.primary.withOpacity(0.7)
                                  : AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            )
                                : Text(
                              'Sign up',
                              style: AppTextStyle.whiteOnBtn,
                            ),
                          ),
                        ),
                      )),
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
