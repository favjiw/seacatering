import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_style.dart';
import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Dashboard', style: AppTextStyle.appBarTitle),
                  InkWell(
                    onTap: ()async{
                      try {
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed('/login');
                      } catch (e) {
                        Get.snackbar('Logout Error', e.toString());
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.gray,
                      radius: 25.r,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              _buildDateRangeSelector(),
              SizedBox(height: 20.h),
              Obx(() => controller.isLoading.value
                  ? _buildShimmerMetrics()
                  : _buildMetricsSection()),
              SizedBox(height: 20.h),
              Obx(() => controller.isLoading.value
                  ? _buildShimmerChart()
                  : _buildSubscriptionChart()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return SizedBox(
            width: 230.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${DateFormat('d MMM y').format(controller.selectedDateRange.value.start)} - ${DateFormat('d MMM y').format(controller.selectedDateRange.value.end)}',
                style: AppTextStyle.adminDate,
              ),
            ),
          );
        }),
        IconButton(
          icon: Icon(Icons.calendar_today_rounded, color: AppColors.text),
          onPressed: () => _showDateRangePicker(Get.context!),
        ),
      ],
    );
  }

  Widget _buildShimmerMetrics() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildShimmerContainer(155.w, 180.h),
            _buildShimmerContainer(155.w, 180.h),
          ],
        ),
        SizedBox(height: 20.h),
        _buildShimmerContainer(337.w, 130.h),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildShimmerContainer(155.w, 180.h),
            _buildShimmerContainer(155.w, 180.h),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerContainer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }

  Widget _buildMetricsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMetricCard(
              'New',
              'Subscription',
              controller.newSubscriptions.value.toString(),
              AppColors.black,
            ),
            _buildMetricCard(
              'Total',
              'Subscription',
              controller.totalSubscriptionsAllTime.value.toString(),
              AppColors.white,
              showAllTime: true,
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _buildRevenueCard(),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMetricCard(
              'Cancelled',
              'Subscription',
              controller.cancelledSubscriptions.value.toString(),
              HexColor('#FF4F4F'),
            ),
            _buildMetricCard(
              'Reactivated',
              'Subscription',
              controller.reactivations.value.toString(),
              AppColors.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
      String title1,
      String title2,
      String value,
      Color backgroundColor, {
        bool showAllTime = false,
      }) {
    return Container(
      width: 155.w,
      height: 180.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          Text(title1, style: backgroundColor == AppColors.white
              ? AppTextStyle.adminBlackTitle
              : AppTextStyle.adminWhtTitle),
          Text(title2, style: backgroundColor == AppColors.white
              ? AppTextStyle.adminBlackTitle
              : AppTextStyle.adminWhtTitle),
          SizedBox(height: 10.h),
          Text(value, style: backgroundColor == AppColors.white
              ? AppTextStyle.adminBlackNum
              : AppTextStyle.adminWhtNum),
          if (showAllTime) SizedBox(height: 5.h),
          if (showAllTime) Text('All Time', style: AppTextStyle.adminBlackTitle),
        ],
      ),
    );
  }

  Widget _buildRevenueCard() {
    return Container(
      width: 337.w,
      height: 130.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.h),
            Text('Monthly Recurring Revenue (MRR)',
                style: AppTextStyle.adminWhtTitle),
            SizedBox(height: 5.h),
            SizedBox(
              width: 250.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  controller.formatCurrency(controller.monthlyRevenue.value),
                  style: AppTextStyle.adminWhtNum,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget _buildShimmerChart() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 400.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }

  Widget _buildSubscriptionChart() {
    return SizedBox(
      height: 400.h,
      width: double.maxFinite,
      child: Obx(() {
        return SfCartesianChart(
          title: ChartTitle(text: 'Subscription Growth'),
          legend: Legend(isVisible: true),
          primaryXAxis: CategoryAxis(),
          series: <CartesianSeries>[
            LineSeries<Map<String, dynamic>, String>(
              dataSource: controller.subscriptionGrowthData.value,
              xValueMapper: (data, _) => data['month'] as String,
              yValueMapper: (data, _) => data['count'] as int,
              name: 'Subscription',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final now = DateTime.now();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Date Range'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                controller.selectedDateRange.value.start,
                controller.selectedDateRange.value.end,
              ),
              minDate: DateTime(2020),
              maxDate: now,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final range = args.value;
                  if (range.startDate != null && range.endDate != null) {
                    // No date adjustment here - let the controller handle it
                    controller.updateDateRange(DateTimeRange(
                      start: range.startDate!,
                      end: range.endDate!,
                    ));
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}