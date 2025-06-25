import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/plan_selection_tile.dart';
import '../controllers/subscription_form_controller.dart';

class SubscriptionFormView extends GetView<SubscriptionFormController> {
  const SubscriptionFormView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          title: Text('Subscription Plan'),
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
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Create a Plan", style: AppTextStyle.subsTitle)),
                  SizedBox(height: 15.h),
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      child: Text(
                        "Crafted by chefs, backed by nutritionists.\nChoose your path to better eating.",
                        style: AppTextStyle.subsSubTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Obx(()=>
                      Column(
                        children: [
                          PlanSelectionTile(
                            title: 'Diet Plan',
                            price: 'Rp30.000/meal',
                            isSelected: controller.selectedPlan.value == 'Diet',
                            onTap: () => controller.setSelectedPlan('Diet'),
                          ),
                          SizedBox(height: 16.h),
                          PlanSelectionTile(
                            title: 'Protein Plan',
                            price: 'Rp40.000/meal',
                            isSelected: controller.selectedPlan.value == 'Protein',
                            onTap: () => controller.setSelectedPlan('Protein'),
                          ),
                          SizedBox(height: 16.h),
                          PlanSelectionTile(
                            title: 'Royal Plan',
                            price: 'Rp60.000/meal',
                            isSelected: controller.selectedPlan.value == 'Royal',
                            onTap: () => controller.setSelectedPlan('Royal'),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(height: 28.h),
                  Text("Meal type", style: AppTextStyle.subsLabel),
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.mealOptions.map((meal) {
                        final bool isSelected = controller.selectedMeals.contains(meal);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: GestureDetector(
                            onTap: () => controller.toggleMeal(meal),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20.w,
                                    height: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                        width: 1.5.w,
                                      ),
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.transparent,
                                    ),
                                    child: isSelected
                                        ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16.sp,
                                    )
                                        : null,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    meal,
                                    style: AppTextStyle.subsCheck,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      if (!controller.isMealTypeValid.value)
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Text(
                            "Minimal pilih 1 meal type",
                            style: AppTextStyle.error,
                          ),
                        ),
                    ],
                  )),
                  SizedBox(height: 28.h),
                  Text("Delivery Days", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  Obx(() {
                    final items = controller.deliveryDays;
                    final selected = controller.selectedDeliveryDays;
                    return Padding(
                      padding: EdgeInsets.only(left: 11.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 20.w,
                            runSpacing: 21.h,
                            children: List.generate(items.length, (index) {
                              final day = items[index];
                              final isSelected = selected.contains(day);
                              return SizedBox(
                                width: (Get.width - 80.w) / 2,
                                child: GestureDetector(
                                  onTap: () => controller.toggleDeliveryDay(day),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20.w,
                                        height: 20.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.r),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.grey.shade400,
                                            width: 1.5.w,
                                          ),
                                          color:
                                          isSelected ? Colors.black : Colors.transparent,
                                        ),
                                        child: isSelected
                                            ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16.sp,
                                        )
                                            : null,
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(day, style: AppTextStyle.subsCheck),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          if (!controller.isDeliveryDayValid.value)
                            Padding(
                              padding: EdgeInsets.only(top: 6.h),
                              child: Text(
                                "Minimal pilih 1 delivery day",
                                style: AppTextStyle.error,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 28.h),
                  Text("Allergies", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  CustomTextField(
                    controller: controller.allergieController,
                    hintText: "Eggs, Fish, Milk",
                    hintStyle: AppTextStyle.hintStyle,
                    inputStyle: AppTextStyle.inputStyle,
                    width: 344.w,
                    height: 56.h,
                  ),
                  SizedBox(height: 28.h),
                  Text("Let us know if you have any request!", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  CustomTextField(
                    controller: controller.moreController,
                    hintText: "More eggs!",
                    hintStyle: AppTextStyle.hintStyle,
                    inputStyle: AppTextStyle.inputStyle,
                    width: 344.w,
                    height: 56.h,
                  ),
                  SizedBox(height: 100.h,),
                ],
              ),
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
           text: "Subscribe",
           onPressed: () {
             if (controller.validateCheckboxFields()) {
               Get.log("valid..lanjut");
             }
           },
         ),
       ),
      ),
    );
  }
}
