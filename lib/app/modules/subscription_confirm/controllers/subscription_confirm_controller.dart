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

  Future<void> submitSubscription() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      final subscriptionDoc = data.toFirestoreMap();
      subscriptionDoc.addAll({
        'user_id': uid,
        'total_payment': totalPayment.value.round(),
        'pause_periode_start': null,
        'pause_periode_end': null,
      });

      await FirebaseFirestore.instance
          .collection('subscriptions')
          .add(subscriptionDoc);

      Get.snackbar("Sukses", "Subscription berhasil disimpan");
      Get.offAllNamed('/botnavbar');
    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan subscription: $e");
      Get.log("Error submitSubscription: $e", isError: true);
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
