import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/Subscripton.dart';
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
                  SizedBox(height: 20.h,),
                  Text("Full Name", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  CustomTextField(
                    width: 344.w,
                    height: 56.h,
                    controller: controller.nameController,
                    hintText: "Full Name",
                    hintStyle: AppTextStyle.hintStyle,
                    inputStyle: AppTextStyle.inputStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h,),
                  Text("Phone Number", style: AppTextStyle.subsLabel),
                  SizedBox(height: 13.h),
                  CustomTextField(
                    width: 344.w,
                    height: 56.h,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    controller: controller.phoneController,
                    keyboardType: TextInputType.numberWithOptions(),
                    hintText: "Your phone number",
                    hintStyle: AppTextStyle.hintStyle,
                    inputStyle: AppTextStyle.inputStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h,),
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
                  Obx(() {
                    if (controller.isLoadingMealPlans.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: controller.mealPlans.map((plan) {
                        return Column(
                          children: [
                            PlanSelectionTile(
                              title: plan.name,
                              price: "Rp${plan.price}/meal",
                              isSelected: controller.selectedPlan.value?.id == plan.id,
                              onTap: () => controller.setSelectedPlan(plan),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(height: 28.h),
                  Text("Meal Type", style: AppTextStyle.subsLabel),
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
          child: CustomButton(
            text: "Subscribe",
            onPressed: () {
              // Validasi form
              final isFormValid = controller.formKey.currentState?.validate() ?? false;
              final isCheckboxValid = controller.validateCheckboxFields();

              if (!isFormValid || !isCheckboxValid) {
                Get.snackbar("Error", "Harap lengkapi semua field");
                return;
              }

              // Pastikan plan terpilih
              if (controller.selectedPlan.value == null) {
                Get.snackbar("Error", "Silakan pilih meal plan");
                return;
              }

              // Kirim data
              final data = SubscriptionData(
                name: controller.nameController.text,
                phone: controller.phoneController.text,
                selectedPlan: controller.selectedPlan.value!.name,
                selectedPlanId: controller.selectedPlan.value!.id,
                selectedMeals: controller.selectedMeals.toList(),
                selectedDeliveryDays: controller.selectedDeliveryDays.toList(),
                allergies: controller.allergieController.text,
                additionalRequest: controller.moreController.text,
              );

              Get.toNamed('/subscription-confirm', arguments: data);
            },
          ),
        ),
      ),
    );
  }
}
