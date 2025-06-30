import 'package:cloud_firestore/cloud_firestore.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.pageBackground,
          elevation: 0,
          centerTitle: true,
          title: Text('Subscription'),
          titleTextStyle: AppTextStyle.appBarTitle,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: AppTextStyle.menuDetSubT,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(text: 'Current'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.currentSubscription.value != null) {
                return _buildCurrentSubscription();
              } else {
                return _buildNoSubscription();
              }
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildSubscriptionHistory();
            }),
          ],
        ),
      ),
    );

  }

  Widget _buildCurrentSubscription() {
    final subscription = controller.currentSubscription.value!;
    final status = subscription['status'] ?? 'N/A';

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
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
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Review',
                  onPressed: () {
                    final current = controller.currentSubscription.value;
                    if (current != null) {
                      Get.toNamed('/testimony', arguments: {
                        'subscriptionId': current['id'],
                        'planId': current['plan_id'],
                        'planName': current['plan_name'],
                        'deliveryDays': current['delivery_days'],
                        'mealTypes': current['meal_type'],
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionHistory() {
    return Obx(() {
      if (controller.subscriptionHistory.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/empty-subscription.png',
                width: 200.w,
                height: 200.h,
              ),
              SizedBox(height: 20.h),
              Text(
                'No subscription history found',
                style: AppTextStyle.confVal,
              ),
            ],
          ),
        );
      }
      return ListView.builder(
        itemCount: controller.subscriptionHistory.length,
        itemBuilder: (context, index) {
          final data = controller.subscriptionHistory[index];
          final isCanceled = data['status'] == 'CANCELLED';
          final canReactivate = isCanceled &&
              (data['is_reactivated'] != true ||
                  (data['reactivate_count'] ?? 0) < 3);

          final hasActiveSubscription = controller.hasActiveSubscription;
          final endDate = data['end_date']?.toDate() ?? DateTime.now();
          final isExpired = endDate.isBefore(DateTime.now());

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            width: 333.w,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: SizedBox(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['status'] ?? 'Unknown Status',
                          style: AppTextStyle.confVal,
                        ),
                        Text(
                          data['plan_name'] ?? 'Unknown Plan',
                          style: AppTextStyle.confVal,
                        ),
                        Text(
                          '${controller.formatDate(data['created_at'])}',
                          style: AppTextStyle.confVal,
                        ),
                        Text(
                          '${controller.formatDate(data['end_date'])}',
                          style: AppTextStyle.confVal,
                        ),
                        if (isExpired)
                          Text(
                            'Expired',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${controller.formatCurrency(data['total_payment'])}',
                        style: AppTextStyle.confVal,
                      ),
                      SizedBox(height: 10.h),
                      if (isCanceled && canReactivate)
                        Column(
                          children: [
                            CustomButton(
                              text: 'Reactivate',
                              onPressed: (hasActiveSubscription || isExpired)
                                  ? null
                                  : () => _confirmReactivate(data['id']),
                              backgroundColor: (hasActiveSubscription || isExpired)
                                  ? Colors.grey
                                  : AppColors.primary,
                            ),
                            if (hasActiveSubscription || isExpired)
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  hasActiveSubscription
                                      ? 'You already have an active subscription'
                                      : 'This subscription has expired',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        text: 'Review',
                        onPressed: () {
                          Get.toNamed('/testimony', arguments: {
                            'subscriptionId': data['id'],
                            'planId': data['plan_id'],
                            'planName': data['plan_name'],
                            'deliveryDays': data['delivery_days'],
                            'mealTypes': data['meal_type'],
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
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
    final subscription = controller.currentSubscription.value;
    if (subscription == null) return SizedBox.shrink();

    final status = subscription['status'] ?? 'N/A';
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
    return CustomButton(
      text: 'Pause',
      onPressed: () => _confirmPauseSubscription(),
      backgroundColor: Colors.orange,
      textStyle: AppTextStyle.whiteOnBtn,
    );
  }

  Widget _buildCancelButton() {
    return CustomButton(
      text: 'Cancel',
      onPressed: () => _confirmCancelSubscription(),
      backgroundColor: Colors.red,
      textStyle: AppTextStyle.whiteOnBtn,
    );
  }

  Widget _buildResumeButton() {
    return CustomButton(
      text: 'Activate',
      onPressed: () => _confirmResumeSubscription(),
      backgroundColor: Colors.green,
      textStyle: AppTextStyle.whiteOnBtn,
    );
  }

  void _confirmReactivate(String subscriptionId) {
    Get.defaultDialog(
      title: 'Reactivate Subscription',
      titleStyle: AppTextStyle.adminBlackTitle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This will:', style: AppTextStyle.body),
          SizedBox(height: 4.h),
          Text('- Set start date to today', style: AppTextStyle.body),
          Text('- Set end date to 1 month from now', style: AppTextStyle.body),
          Text('- Reset subscription status to ACTIVE', style: AppTextStyle.body),
          SizedBox(height: 10.h),
          Text('Are you sure?', style: AppTextStyle.body),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        Obx(
              () => ElevatedButton(
            onPressed: controller.isUpdating.value
                ? null
                : () async {
              try {
                controller.isUpdating.value = true;
                Get.log("Reactivate button pressed");
                await controller.reactivateSubscription(subscriptionId);
              } finally {
                Get.back(closeOverlays: true);
                controller.isUpdating.value = false;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: controller.isUpdating.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Confirm Reactivate'),
          ),
        ),
      ],
    );
  }

  void _confirmCancelSubscription() {
    Get.defaultDialog(
      title: 'Cancel Subscription',
      titleStyle: AppTextStyle.adminBlackTitle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to cancel your subscription?',
            style: AppTextStyle.body,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            'This action cannot be undone.',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: const Text('No')
        ),
        Obx(
              () => ElevatedButton(
            onPressed: controller.isUpdating.value
                ? null
                : () async {
              try {
                controller.isUpdating.value = true;
                Get.log("Cancel button pressed");
                await controller.cancelSubscription();
              } finally {
                Get.back(closeOverlays: true);
                controller.isUpdating.value = false;
              }
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
    DateTime startDate = DateTime.now();
    if (startDate.isBefore(controller.subscriptionStartDate)) {
      startDate = controller.subscriptionStartDate;
    } else if (startDate.isAfter(controller.subscriptionEndDate)) {
      startDate = controller.subscriptionEndDate.subtract(const Duration(days: 1));
    }

    DateTime endDate = startDate.add(const Duration(days: 7));
    if (endDate.isAfter(controller.subscriptionEndDate)) {
      endDate = controller.subscriptionEndDate;
    }

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Pause Subscription', textAlign: TextAlign.center,),
            titleTextStyle: AppTextStyle.adminBlackTitle,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select pause period:', style: AppTextStyle.body),
                SizedBox(height: 20.h),
                ListTile(
                  title: Text('From', style: AppTextStyle.body),
                  subtitle: Text(DateFormat('dd MMM yyyy').format(startDate), style: AppTextStyle.confLabel),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today_rounded),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: controller.subscriptionStartDate,
                        lastDate: controller.subscriptionEndDate,
                        selectableDayPredicate: (date) =>
                        date.isAfter(controller.subscriptionStartDate.subtract(const Duration(days: 1))) &&
                            date.isBefore(controller.subscriptionEndDate),
                      );
                      if (picked != null) {
                        setState(() {
                          startDate = picked;
                          if (endDate.isBefore(startDate) || endDate.isAtSameMomentAs(startDate)) {
                            endDate = startDate.add(const Duration(days: 1));
                          }
                          if (endDate.isAfter(controller.subscriptionEndDate)) {
                            endDate = controller.subscriptionEndDate;
                          }
                        });
                      }
                    },
                  ),
                ),
                ListTile(
                  title: Text('To'),
                  titleTextStyle: AppTextStyle.adminBlackTitle,
                  subtitle: Text(DateFormat('dd MMM yyyy').format(endDate)),
                  subtitleTextStyle: AppTextStyle.confLabel,
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today_rounded),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: startDate.add(const Duration(days: 1)),
                        lastDate: controller.subscriptionEndDate,
                        selectableDayPredicate: (date) =>
                        date.isAfter(startDate) &&
                            date.isBefore(controller.subscriptionEndDate.add(const Duration(days: 1))),
                      );
                      if (picked != null) {
                        setState(() {
                          endDate = picked;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
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
          );
        },
      ),
    );
  }

  void _confirmResumeSubscription() {
    Get.defaultDialog(
      title: 'Resume Subscription',
      titleStyle: AppTextStyle.adminBlackTitle,
      content: Center(
        child: Text(
          'Are you sure you want to resume your subscription? (There will be no charge)',
          style: AppTextStyle.body,
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('No'),
        ),
        Obx(
              () => ElevatedButton(
            onPressed: controller.isUpdating.value
                ? null
                : () async {
              try {
                controller.isUpdating.value = true;
                await controller.resumeSubscription();
              } catch (e) {
                debugPrint('[ERROR] In resumeSubscription: $e');
              } finally {
                Get.back(closeOverlays: true);
                controller.isUpdating.value = false;
              }
            },
            child: controller.isUpdating.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Yes, Resume'),
          ),
        ),
      ],
    );
  }
}
