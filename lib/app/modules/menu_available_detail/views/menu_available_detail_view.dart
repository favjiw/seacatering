import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
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
        backgroundColor: HexColor('#D3FFED'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.w, bottom: 45.h, top: 20.h, right: 15.w),
              width: 1.sw,
              color: HexColor('#D3FFED'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type', style: AppTextStyle.menuDetLabel,),
                      Text(controller.menu.name, style: AppTextStyle.menuDetTitle,),
                      SizedBox(height: 40.h),
                      Text('Calories', style: AppTextStyle.menuDetLabel,),
                      Text('${controller.menu.calories} kcal', style: AppTextStyle.menuDetTitle,),
                      SizedBox(height: 40.h),
                      Text('Price', style: AppTextStyle.menuDetLabel,),
                      Text(controller.formatPrice(controller.menu.price), style: AppTextStyle.menuDetTitle),
                      Text('/meal', style: AppTextStyle.menuDetLabel),
                    ]
                  ),
                  Container(
                    width: 180.w,
                    height: 180.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Stack(
                        children: [
                          Image.network(
                            controller.menu.imageUrl,
                            width: 180.w,
                            height: 180.h,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 180.w,
                                  height: 180.h,
                                  color: Colors.white,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.fastfood_rounded,
                                        size: 50.w,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Image not available',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'Description',
                    style: AppTextStyle.menuDetSubT,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    controller.menu.desc,
                    style: AppTextStyle.menuDetSubV,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Nutritional Information',
                    style: AppTextStyle.menuDetSubT,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Calories: ${controller.menu.calories} kcal', style: AppTextStyle.menuDetSubV),
                      Text('Fiber: ${controller.menu.fiber} g', style: AppTextStyle.menuDetSubV),
                      SizedBox(width: 10.w,),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Protein: ${controller.menu.protein} g', style: AppTextStyle.menuDetSubV),
                      Text('Fat: ${controller.menu.fat} g', style: AppTextStyle.menuDetSubV),
                      SizedBox(width: 10.w,),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text('Carbs: ${controller.menu.carbs} g', style: AppTextStyle.menuDetSubV),
                  SizedBox(height: 20.h),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Testimonies',
                              style: AppTextStyle.menuDetSubT,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              '(${controller.testimonies.length})',
                              style: AppTextStyle.menuDetSubV,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        if (controller.testimonies.isEmpty)
                          Text(
                            'No testimonies yet',
                            style: AppTextStyle.menuDetSubV,
                          ),

                        ...controller.testimonies.map((testimony) => Container(
                          width: 310.w,
                          padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.w,
                                color: HexColor('#E0E0E0'),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      testimony.userName,
                                      style: AppTextStyle.menuDetSubT,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(width: 8.w), // Add some spacing
                                  Text(
                                    controller.formatDate(testimony.createdAt),
                                    style: AppTextStyle.menuDetSubV,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              // Display star rating
                              Row(
                                children: List.generate(5, (index) => Icon(
                                  index < testimony.rating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20.w,
                                )),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                testimony.message,
                                style: AppTextStyle.menuDetSubV,
                              ),
                            ],
                          ),
                        )).toList(),
                        SizedBox(height: 50.h),
                      ],
                    );
                  }),
                  SizedBox(height: 50.h,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
