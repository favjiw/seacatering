import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/Testimony.dart';

class MenuAvailableDetailController extends GetxController {
  final menu = Get.arguments;
  final testimonies = <Testimony>[].obs;
  final isLoading = false.obs;

  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  void onInit() {
    super.onInit();
    fetchTestimonies();
  }

  Future<void> fetchTestimonies() async {
    try {
      isLoading(true);
      final querySnapshot = await FirebaseFirestore.instance
          .collection('testimonies')
          .where('plan_id', isEqualTo: menu.id)
          .where('is_approved', isEqualTo: true)
          .orderBy('created_at', descending: true)
          .get();

      testimonies.assignAll(
        querySnapshot.docs.map((doc) => Testimony.fromFirestore(doc)).toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch testimonies: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  String formatPrice(int price) {
    return currencyFormat.format(price);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yy').format(date);
  }
}