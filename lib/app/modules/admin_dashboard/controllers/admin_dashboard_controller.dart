import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminDashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  var isLoading = true.obs;
  var newSubscriptions = 0.obs;
  var totalSubscriptionsAllTime = 0.obs;
  var monthlyRevenue = 0.obs;
  var reactivations = 0.obs;
  var activeSubscriptions = 0.obs;
  var cancelledSubscriptions = 0.obs;
  var subscriptionGrowthData = <Map<String, dynamic>>[].obs;
  var selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData(selectedDateRange.value);
  }

  DateTime _startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime _endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  Future<void> updateDateRange(DateTimeRange newRange) async {
    selectedDateRange.value = DateTimeRange(
      start: _startOfDay(newRange.start),
      end: _endOfDay(newRange.end),
    );
    await fetchDashboardData(selectedDateRange.value);
  }

  Future<void> fetchDashboardData(DateTimeRange dateRange) async {
    isLoading.value = true;

    try {
      final startTimestamp = Timestamp.fromDate(dateRange.start);
      final endTimestamp = Timestamp.fromDate(dateRange.end);

      // 1. New subscriptions (created within date range)
      final newSubsQuery = await _firestore
          .collection('subscriptions')
          .where('created_at', isGreaterThanOrEqualTo: startTimestamp)
          .where('created_at', isLessThanOrEqualTo: endTimestamp)
          .get();
      newSubscriptions.value = newSubsQuery.docs.length;

      // 2. Total subscriptions all time (all subscriptions regardless of status)
      final allSubsQuery = await _firestore
          .collection('subscriptions')
          .get();
      totalSubscriptionsAllTime.value = allSubsQuery.docs.length;

      // 3. Monthly revenue (sum of payments from ACTIVE subscriptions in date range)
      int revenue = 0;
      final revenueQuery = await _firestore
          .collection('subscriptions')
          .where('status', isEqualTo: 'ACTIVE')
          .where('created_at', isGreaterThanOrEqualTo: startTimestamp)
          .where('created_at', isLessThanOrEqualTo: endTimestamp)
          .get();

      for (var doc in revenueQuery.docs) {
        revenue += (doc['total_payment'] as int? ?? 0);
      }
      monthlyRevenue.value = revenue;

      // 4. Reactivations (status changed from CANCELLED to ACTIVE in date range)
      final reactivationsQuery = await _firestore
          .collection('subscriptions')
          .where('is_reactivated', isEqualTo: true)
          .where('updated_at', isGreaterThanOrEqualTo: startTimestamp)
          .where('updated_at', isLessThanOrEqualTo: endTimestamp)
          .get();
      reactivations.value = reactivationsQuery.docs.length;

      // 5. Active subscriptions (current ACTIVE subscriptions)
      final activeSubsQuery = await _firestore
          .collection('subscriptions')
          .where('status', isEqualTo: 'ACTIVE')
          .get();
      activeSubscriptions.value = activeSubsQuery.docs.length;

      final cancelledQuery = await _firestore
          .collection('subscriptions')
          .where('status', isEqualTo: 'CANCELLED')
          .where('cancelled_at', isGreaterThanOrEqualTo: startTimestamp)
          .where('cancelled_at', isLessThanOrEqualTo: endTimestamp)
          .get();
      cancelledSubscriptions.value = cancelledQuery.docs.length;

      // 6. Subscription growth (last 12 months)
      final growthData = <Map<String, dynamic>>[];
      final now = DateTime.now();

      for (int i = 11; i >= 0; i--) {
        final monthStart = DateTime(now.year, now.month - i, 1);
        final monthEnd = DateTime(now.year, now.month - i + 1, 0);
        final monthEndTimestamp = Timestamp.fromDate(monthEnd);

        // Get subscriptions active at the end of each month
        final query = await _firestore
            .collection('subscriptions')
            .where('start_date', isLessThanOrEqualTo: monthEndTimestamp)
            .get();

        final activeAtMonthEnd = query.docs.where((doc) {
          final status = doc['status'] as String?;
          final endDate = doc['end_date'] as Timestamp?;
          return status == 'ACTIVE' &&
              (endDate == null || endDate.toDate().isAfter(monthEnd));
        }).length;

        growthData.add({
          'month': DateFormat('MMM y').format(monthStart),
          'count': activeAtMonthEnd,
        });
      }
      subscriptionGrowthData.value = growthData;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch dashboard data: ${e.toString()}');
      Get.log('Error fetching dashboard data: $e', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  String formatCurrency(int amount) {
    return currencyFormat.format(amount);
  }
}