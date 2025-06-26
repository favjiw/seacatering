import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuAvailableDetailController extends GetxController {
  //TODO: Implement MenuAvailableDetailController
  final menu = Get.arguments;

  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  String formatPrice(int price) {
    return currencyFormat.format(price);
  }

  @override
  void onInit() {
    super.onInit();
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
