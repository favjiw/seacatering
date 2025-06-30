import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/Subscripton.dart';
import '../../subscription/controllers/subscription_controller.dart';

class ReactivateConfirmController extends GetxController {
  final SubscriptionData data = Get.arguments as SubscriptionData;
  late int mealPrice;
  final double feePerDelivery = 4.3;
  final RxDouble totalPayment = 0.0.obs;
  final RxBool isUpdating = false.obs;
  final SubscriptionController _subscriptionController = Get.find();

  String get formattedTotal => NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  ).format(totalPayment.value);

  String get formattedMeal => NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  ).format(mealPrice);

  void _initPayment() {
    switch (data.selectedPlan.toLowerCase()) {
      case 'diet plan':
        mealPrice = 30000;
        break;
      case 'royal plan':
        mealPrice = 60000;
        break;
      case 'protein plan':
        mealPrice = 40000;
        break;
      default:
        mealPrice = 0;
    }

    final int mealTypeCount = data.selectedMeals.length;
    final int deliveryDayCount = data.selectedDeliveryDays.length;

    totalPayment.value = mealPrice.toDouble() *
        mealTypeCount.toDouble() *
        deliveryDayCount.toDouble() *
        feePerDelivery;
  }

  Future<void> reactivateExistingSubscription() async {
    try {
      isUpdating.value = true;

      if (_subscriptionController.hasActiveSubscription) {
        Get.snackbar('Error', 'You already have an active subscription');
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(data.id)
          .get();

      final currentTotalPayment = doc['total_payment'] ?? 0;
      if (currentTotalPayment is! int) {
        throw Exception('Invalid total_payment format in database');
      }

      _initPayment();
      final newPayment = totalPayment.value.round();
      final updatedTotalPayment = currentTotalPayment + newPayment;

      final now = DateTime.now();
      final updateData = {
        'status': 'ACTIVE',
        'start_date': Timestamp.fromDate(now),
        'end_date': Timestamp.fromDate(now.add(Duration(days: 30))),
        'is_reactivated': true,
        'reactivate_count': FieldValue.increment(1),
        'total_payment': updatedTotalPayment, // Gunakan nilai yang diakumulasi
        'payment_status': 'PENDING',
        'last_reactivated_at': FieldValue.serverTimestamp(),
        'cancelled_at': null,
        'pause_periode_start': null,
        'pause_periode_end': null,
        'updated_at': FieldValue.serverTimestamp(),
      };

      final paymentSuccess = await _processPayment(newPayment);
      if (!paymentSuccess) {
        throw Exception('Payment processing failed');
      }

      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(data.id)
          .update({
        ...updateData,
        'payment_status': 'PAID',
        'paid_at': FieldValue.serverTimestamp(),
      });

      await _subscriptionController.fetchAllSubscriptions();

      Get.snackbar(
          'Success',
          'Subscription reactivated!'
      );
      Get.offAllNamed('/botnavbar');

    } catch (e) {
      Get.snackbar(
          'Error',
          'Failed to reactivate: ${e.toString().replaceAll('Exception: ', '')}'
      );
      Get.log("Reactivate error: $e", isError: true);
    } finally {
      isUpdating.value = false;
    }
  }

  Future<bool> _processPayment(int amount) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    _initPayment();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
