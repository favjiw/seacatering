import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seacatering/app/shared/widgets/custom_button.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Subscription'),
        titleTextStyle: AppTextStyle.appBarTitle,
        centerTitle: true,
        backgroundColor: AppColors.pageBackground,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.hasSubscription.value) {
          return _buildCurrentSubscription();
        } else {
          return _buildNoSubscription();
        }
      }),
    );
  }

  Widget _buildCurrentSubscription() {
    final subscription = controller.currentSubscription!;
    final status = subscription['status'] ?? 'N/A';
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Your ${status == 'PAUSED' ? 'Paused' : 'Active'} Subscription',
              style: AppTextStyle.homeTitle,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: status == 'PAUSED'
                  ? Colors.grey.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: status == 'PAUSED' ? Colors.grey : AppColors.primary,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => _buildDetailRow(
                    'Plan:',
                    controller.isFetchingPlanName.value
                        ? 'Loading...'
                        : controller.planName,
                  ),
                ),
                _buildDetailRow('Status:',
                    (subscription['status'] ?? 'N/A') +
                        (status == 'PAUSED' ?
                        '\n(Paused until ${controller.formatDate(subscription['pause_periode_end'])})' :
                        '')
                ),
                _buildDetailRow(
                  'Phone:',
                  subscription['phone_number'] ?? 'N/A',
                ),
                _buildDetailRow(
                  'Total Payment:',
                  controller.formatCurrency(subscription['total_payment']),
                ),
                _buildDetailRow(
                  'Created At:',
                  controller.formatDate(subscription['created_at']),
                ),
                _buildDetailRow(
                  'End Date:',
                  controller.formatDate(subscription['end_date']),
                ),

                SizedBox(height: 15.h),
                Text('Delivery Days:', style: AppTextStyle.confVal),
                _buildChipList(controller.deliveryDays ?? []),

                SizedBox(height: 15.h),
                Text('Meal Types:', style: AppTextStyle.confVal),
                _buildChipList(controller.mealTypes ?? []),

                SizedBox(height: 15.h),
                Text('Allergies:', style: AppTextStyle.confVal),
                _buildChipList(controller.allergies ?? [], isAllergy: true),
                SizedBox(height: 20.h),
                _buildActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(label, style: AppTextStyle.confLabel),
          ),
          Expanded(child: Text(value, style: AppTextStyle.confVal)),
        ],
      ),
    );
  }

  Widget _buildChipList(List<String> items, {bool isAllergy = false}) {
    if (items.isEmpty) {
      return Text(
        'None specified',
        style: AppTextStyle.confVal.copyWith(color: Colors.grey),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          items.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor:
                  isAllergy
                      ? Colors.red[100]
                      : AppColors.primary.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isAllergy ? Colors.red[800] : AppColors.primary,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildActionButtons() {
    final status = controller.currentSubscription?['status'] ?? 'N/A';
    return Column(
      children: [
        if (status == 'PAUSED') ...[
          _buildResumeButton(),
          SizedBox(height: 10.h),
          _buildCancelButton(),
        ] else if (status == 'ACTIVE') ...[
          Row(
            children: [
              Expanded(child: _buildPauseButton()),
              SizedBox(width: 10.w),
              Expanded(child: _buildCancelButton()),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPauseButton() {
    return ElevatedButton(
      onPressed: () => _confirmPauseSubscription(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      child: Text('Pause', style: AppTextStyle.whiteOnBtn),
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () => _confirmCancelSubscription(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      child: Text('Cancel', style: AppTextStyle.whiteOnBtn),
    );
  }

  void _confirmCancelSubscription() {
    Get.defaultDialog(
      title: 'Cancel Subscription',
      content: Column(
        children: [
          Text('Are you sure you want to cancel your subscription?'),
          SizedBox(height: 10.h),
          Text(
            'This action cannot be undone.',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('No')),
        Obx(
              () => ElevatedButton(
            onPressed: controller.isUpdating.value
                ? null
                : () async {
              Get.log("Cancel button pressed");
              await controller.cancelSubscription();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: controller.isUpdating.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Yes, Cancel'),
          ),
        ),
      ],
    );
  }

  void _confirmPauseSubscription() {
    final startDate = DateTime.now();
    final endDate = startDate.add(const Duration(days: 7));

    Get.dialog(
      AlertDialog(
        title: const Text('Pause Subscription'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select pause period:'),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('From'),
              subtitle: Text(DateFormat('dd MMM yyyy').format(startDate)),
            ),
            ListTile(
              title: const Text('To'),
              subtitle: Text(DateFormat('dd MMM yyyy').format(endDate)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          Obx(
                () => ElevatedButton(
              onPressed: controller.isUpdating.value
                  ? null
                  : () => controller.pauseSubscription(startDate, endDate),
              child: controller.isUpdating.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Confirm Pause'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeButton() {
    return ElevatedButton(
      onPressed: () => _confirmResumeSubscription(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: Text('Activate', style: AppTextStyle.whiteOnBtn,),
    );
  }

  void _confirmResumeSubscription() {
    Get.defaultDialog(
      title: 'Resume Subscription',
      content: const Text('Are you sure you want to resume your subscription?'),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('No')),
        Obx(
          () => ElevatedButton(
            onPressed:
                controller.isUpdating.value
                    ? null
                    : () => controller.resumeSubscription(),
            child:
                controller.isUpdating.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Yes, Resume'),
          ),
        ),
      ],
    );
  }

  Widget _buildNoSubscription() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-subscription.png',
            width: 244.w,
            height: 238.h,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 28.h,),
          Text('You currently don\'t have any\nactive subscription', textAlign: TextAlign.center, style: AppTextStyle.confVal,),
          SizedBox(height: 28.h,),
          CustomButton(
              width: 277.w,
              height: 58.h,
              text: "Add Subscription", onPressed: () => Get.toNamed('/subscription-form'))
        ],
      ),
    );
  }
}
