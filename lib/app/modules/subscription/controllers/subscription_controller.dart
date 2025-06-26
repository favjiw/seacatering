import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionController extends GetxController {
  final hasSubscription = false.obs;
  final isLoading = true.obs;
  final isUpdating = false.obs;
  final isFetchingPlanName = false.obs;
  Map<String, dynamic>? currentSubscription;
  List<String> deliveryDays = [];
  List<String> mealTypes = [];
  List<String> allergies = [];
  String planName = 'Loading...';
  String? subscriptionId;

  @override
  void onInit() {
    super.onInit();
    checkUserSubscription();
  }

  Future<void> checkUserSubscription() async {
    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('subscriptions')
            .where('user_id', isEqualTo: user.uid)
            .where('status', whereIn: ['ACTIVE', 'PAUSED'])
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          hasSubscription.value = true;
          currentSubscription = doc.data();
          subscriptionId = doc.id;

          deliveryDays = _parseFieldToList(currentSubscription?['delivery_days']);
          mealTypes = _parseFieldToList(currentSubscription?['meal_type']);
          allergies = _parseFieldToList(currentSubscription?['allergies']);

          await fetchPlanName(currentSubscription?['plan_id']);
        } else {
          hasSubscription.value = false;
          currentSubscription = null;
          subscriptionId = null;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to check subscription: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPlanName(String? planId) async {
    if (planId == null || planId.isEmpty) {
      planName = 'Unknown Plan';
      return;
    }

    try {
      isFetchingPlanName.value = true;
      final doc = await FirebaseFirestore.instance
          .collection('meal_plans')
          .doc(planId)
          .get();

      if (doc.exists) {
        planName = doc.data()?['name'] ?? 'Unknown Plan';
      } else {
        planName = 'Plan Not Found';
      }
    } catch (e) {
      planName = 'Error Loading Plan';
      Get.snackbar('Error', 'Failed to fetch plan details: $e');
    } finally {
      isFetchingPlanName.value = false;
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
      await checkUserSubscription();
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

      await checkUserSubscription();
      Get.back(); // Close dialog if open
      Get.snackbar('Success', 'Subscription has been paused');
    } catch (e) {
      Get.snackbar('Error', 'Failed to pause subscription: $e');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> resumeSubscription() async {
    if (subscriptionId == null) return;

    try {
      isUpdating.value = true;
      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(subscriptionId)
          .update({
        'status': 'ACTIVE',
        'pause_periode_start': null,
        'pause_periode_end': null,
      });

      await checkUserSubscription();
      Get.snackbar('Success', 'Subscription has been resumed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to resume subscription: $e');
    } finally {
      isUpdating.value = false;
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