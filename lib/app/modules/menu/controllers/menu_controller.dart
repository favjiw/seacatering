import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/PlanModel.dart';

class MenuPageController extends GetxController {
  final menus = <PlanModel>[].obs;
  final isLoading = true.obs;

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
}
