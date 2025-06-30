import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionController extends GetxController {
  final PageController pageController = PageController();
  final now = DateTime.now();
  final isLoading = true.obs;
  final isUpdating = false.obs;
  final isFetchingPlanName = false.obs;
  final refreshPage = false.obs;

  final allSubscriptions = <Map<String, dynamic>>[].obs;
  final currentSubscription = Rx<Map<String, dynamic>?>(null);
  final subscriptionHistory = <Map<String, dynamic>>[].obs;

  List<String> deliveryDays = [];
  List<String> mealTypes = [];
  List<String> allergies = [];
  String planName = 'Loading...';
  String? subscriptionId;

  @override
  void onInit() {
    super.onInit();
    fetchAllSubscriptions();
  }

  @override
  void onClose() {
    pageController.dispose();
    allSubscriptions.clear();
    subscriptionHistory.clear();
    super.onClose();
  }

  DateTime get subscriptionStartDate {
    return currentSubscription.value?['created_at']?.toDate() ?? DateTime.now();
  }

  DateTime get subscriptionEndDate {
    return currentSubscription.value?['end_date']?.toDate() ?? DateTime.now().add(Duration(days: 30));
  }

  bool isDateSelectable(DateTime date) {
    return date.isAfter(subscriptionStartDate) && date.isBefore(subscriptionEndDate);
  }

  bool get hasActiveSubscription {
    return allSubscriptions.any((sub) => sub['status'] == 'ACTIVE');
  }

  void triggerRefresh() {
    refreshPage.value = true;
    fetchAllSubscriptions().then((_) => refreshPage.value = false);
  }

  Future<void> fetchAllSubscriptions() async {
    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('subscriptions')
            .where('user_id', isEqualTo: user.uid)
            .orderBy('created_at', descending: true)
            .get();

        allSubscriptions.assignAll(snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList());

        final current = allSubscriptions.firstWhere(
              (sub) => ['ACTIVE', 'PAUSED'].contains(sub['status']),
          orElse: () => {},
        );

        if (current.isNotEmpty) {
          currentSubscription.value = current;
          subscriptionId = current['id'];
          planName = current['plan_name'] ?? 'Unknown Plan'; // Use stored plan_name

          deliveryDays = _parseFieldToList(current['delivery_days']);
          mealTypes = _parseFieldToList(current['meal_type']);
          allergies = _parseFieldToList(current['allergies']);
        } else {
          currentSubscription.value = null;
          subscriptionId = null;
        }

        subscriptionHistory.assignAll(allSubscriptions.where(
                (sub) => sub['status'] != current['status'] || current.isEmpty
        ).toList());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch subscriptions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> reactivateSubscription(String subscriptionId) async {
    try {
      if (hasActiveSubscription) {
        Get.snackbar('Error', 'You already have an active subscription');
        return false;
      }

      isUpdating.value = true;
      final now = DateTime.now();
      final newEndDate = now.add(Duration(days: 30));

      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(subscriptionId)
          .update({
        'status': 'ACTIVE',
        'start_date': Timestamp.fromDate(now),
        'end_date': Timestamp.fromDate(newEndDate),
        'is_reactivated': true,
        'reactivate_count': FieldValue.increment(1),
        'cancelled_at': null,
        'last_reactivated_at': FieldValue.serverTimestamp(),
      });

      await fetchAllSubscriptions();
      Get.snackbar('Success', 'Subscription has been reactivated');
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to reactivate subscription: $e');
      return false;
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> cancelSubscription() async {
    Get.log('Attempting to cancel subscription. Current ID: $subscriptionId');

    if (subscriptionId == null) {
      Get.log('Cannot cancel - subscriptionId is null');
      Get.snackbar('Error', 'Subscription ID not found');
      return;
    }

    try {
      isUpdating.value = true;
      Get.log('Updating subscription $subscriptionId to CANCELLED');

      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(subscriptionId)
          .update({
        'status': 'CANCELLED',
        'cancelled_at': FieldValue.serverTimestamp(),
      });

      Get.log('Subscription cancelled successfully');
      await fetchAllSubscriptions();
      Get.back();
      Get.snackbar('Success', 'Subscription has been cancelled');
    } catch (e) {
      Get.log('Error cancelling subscription: $e', isError: true);
      Get.snackbar('Error', 'Failed to cancel subscription: ${e.toString()}');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> pauseSubscription(DateTime startDate, DateTime endDate) async {
    if (subscriptionId == null) return;
    try {
      isUpdating.value = true;
      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(subscriptionId)
          .update({
        'status': 'PAUSED',
        'pause_periode_start': Timestamp.fromDate(startDate),
        'pause_periode_end': Timestamp.fromDate(endDate),
      });

      await fetchAllSubscriptions();
      Get.back();
      Get.snackbar('Success', 'Subscription has been paused');
    } catch (e) {
      Get.snackbar('Error', 'Failed to pause subscription: $e');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> resumeSubscription() async {
    debugPrint('[CONTROLLER] Starting resumeSubscription');
    if (subscriptionId == null) {
      debugPrint('[CONTROLLER] Error: subscriptionId is null');
      return;
    }

    try {
      debugPrint('[CONTROLLER] Updating Firestore document');
      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(subscriptionId)
          .update({
        'status': 'ACTIVE',
        'pause_periode_start': null,
        'pause_periode_end': null,
      });

      debugPrint('[CONTROLLER] Firestore update successful, fetching subscriptions');
      await fetchAllSubscriptions();
      debugPrint('[CONTROLLER] fetchAllSubscriptions completed');

      Get.snackbar('Success', 'Subscription has been resumed');
    } catch (e) {
      debugPrint('[CONTROLLER ERROR] Failed to resume: $e');
      Get.snackbar('Error', 'Failed to resume subscription: $e');
      rethrow;
    }
  }

  List<String> _parseFieldToList(dynamic field) {
    if (field == null) return [];
    if (field is List) return List<String>.from(field);
    if (field is String) return field.split(',').map((e) => e.trim()).toList();
    return [];
  }

  String formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Not set';
    return DateFormat('dd MMMM yyyy').format(timestamp.toDate());
  }

  String formatCurrency(int? amount) {
    if (amount == null) return 'Rp0';
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }
}