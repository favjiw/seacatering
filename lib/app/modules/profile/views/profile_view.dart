import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:seacatering/app/shared/constants/text_style.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/profile_menu_item.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Profile'),
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
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.gray,
                  radius: 40.r,
                ),
              ),
              SizedBox(height: 14.h),
              Obx(
                () => Center(
                  child: Text(
                    controller.username.value,
                    style: AppTextStyle.homeLoc,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(
                () => Center(
                  child: SizedBox(
                    width: 340.w,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        controller.email.value,
                        style: AppTextStyle.profileEmail,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Container(width: 343.w, height: 1.h, color: AppColors.gray),
              SizedBox(height: 14.h),
              Text('Account', style: AppTextStyle.protileItemTitle),
              ProfileMenuItem(
                icon: Icons.person,
                title: 'Edit Profile',
                onTap: () {},
              ),
              SizedBox(height: 14.h),
              ProfileMenuItem(
                icon: Icons.lock,
                title: 'Change password',
                onTap: () {},
              ),
              SizedBox(height: 24.h),
              Text('Help', style: AppTextStyle.protileItemTitle),
              ProfileMenuItem(
                icon: Icons.contacts_rounded,
                title: 'Contact',
                onTap: () {},
              ),
              SizedBox(height: 14.h),
              ProfileMenuItem(
                icon: Icons.report_rounded,
                title: 'Report a problem',
                onTap: () {},
              ),
              SizedBox(height: 24.h),
              Text('Other', style: AppTextStyle.protileItemTitle),
              ProfileMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  controller.logout();
                },
                isDestructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
