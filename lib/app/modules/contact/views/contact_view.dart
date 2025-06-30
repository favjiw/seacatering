import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Contact Us'),
        titleTextStyle: AppTextStyle.appBarTitle,
        centerTitle: true,
        backgroundColor: AppColors.pageBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Center(
            child: Container(
              width: 313.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(17.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 0,
                    blurRadius: 14,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: AppColors.yellowTitle,
                              child: Icon(Icons.person_pin, size: 50.sp, color: AppColors.black,),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manager',
                                  style: AppTextStyle.titleContact,
                                ),
                                Text('Brian', style: AppTextStyle.nameContact),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.phoneNumber.value,
                              style: AppTextStyle.titleContact,
                            ),
                            IconButton(
                              onPressed: () async {
                                await controller.copyPhoneNumber();

                              },
                              padding: EdgeInsets.zero,
                              icon: Obx(() => Icon(
                                Icons.copy_rounded,
                                color: controller.justCopied.value
                                    ? AppColors.primary
                                    : AppColors.gray,
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: HexColor('#76FFEA'),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17.r),
                        bottomRight: Radius.circular(17.r),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: controller.contactViaWhatsApp,
                          child: Container(
                            padding: EdgeInsets.all(7),
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: HexColor('#25D366'),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Image.asset('assets/images/WhatsApp.png'),
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(7),
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: HexColor('#25D366'),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Image.asset('assets/images/Phone.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
