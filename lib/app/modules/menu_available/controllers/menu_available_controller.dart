import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/PlanModel.dart';

class MenuAvailableController extends GetxController {
  //TODO: Implement MenuAvailableController
  final menus = <PlanModel>[].obs;
  final isLoading = true.obs;

  final count = 0.obs;

  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  String formatPrice(int price) {
    return currencyFormat.format(price);
  }

  Future<void> fetchMenus() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('meal_plans').get();
      menus.value = snapshot.docs
          .map((doc) => PlanModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data menu: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMenus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
