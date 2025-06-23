import 'package:get/get.dart';

class BotnavbarController extends GetxController {
  //TODO: Implement BotnavbarController

  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
