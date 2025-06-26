import 'package:get/get.dart';

import '../controllers/menu_available_detail_controller.dart';

class MenuAvailableDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuAvailableDetailController>(
      () => MenuAvailableDetailController(),
    );
  }
}
