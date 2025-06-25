import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/Subscripton.dart';


class SubscriptionConfirmController extends GetxController {
  //TODO: Implement SubscriptionConfirmController
  final SubscriptionData data = Get.arguments as SubscriptionData;
  late int mealPrice;
  final double feePerDelivery = 4.3;
  final RxDouble totalPayment = 0.0.obs;

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
        mealPrice = 40000;
        break;
      case 'royal plan':
        mealPrice = 60000;
        break;
      case 'protein plan':
        mealPrice = 50000;
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

  Future<void> submitSubscription() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      final doc = {
        'user_id': uid,
        'phone_number': data.phone,
        'plan_id': data.selectedPlanId,
        'meal_type': data.selectedMeals,
        'delivery_days': data.selectedDeliveryDays,
        'allergies': data.allergies,
        'status': 'ACTIVE',
        'end_date': Timestamp.fromDate(DateTime.now().add(Duration(days: 30))),
        'pause_periode_start': null,
        'pause_periode_end': null,
        'created_at': FieldValue.serverTimestamp(),
        'total_payment': totalPayment.value.round(),
      };

      await FirebaseFirestore.instance.collection('subscriptions').add(doc);

      Get.snackbar("Sukses", "Subscription berhasil disimpan");
      Get.offAllNamed('/botnavbar');
    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan subscription: $e");
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
