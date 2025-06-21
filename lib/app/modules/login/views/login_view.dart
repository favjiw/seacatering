import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/colors.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';
import 'package:seacatering/app/shared/widgets/custom_text_field.dart';

import '../../../shared/widgets/custom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Center(
                  child: Image.asset(
                    'assets/images/SEA.png',
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
                Text('Sign in', style: AppTextStyle.signTitle),
                SizedBox(height: 20.h),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
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
                      SizedBox(height: 20.h),
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
                      // SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {},
                          child: Text('Forgot Password?', style: AppTextStyle.textBtn,),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        width: 271.w,
                        height: 60.h,
                        text: 'Sign in',
                        textStyle: AppTextStyle.whiteOnBtn,
                        backgroundColor: AppColors.primary,
                        borderRadius: 15.r,
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                              controller.signIn(controller.emailController.text, controller.passwordController.text);
                            } else {
                              Get.snackbar(
                                'Form Error',
                                'Please fill in both email and password.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.withOpacity(0.8),
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 2),
                              );
                            }
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?', style: AppTextStyle.body),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: Text('Sign up', style: AppTextStyle.textBtn),
                    ),
          ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
