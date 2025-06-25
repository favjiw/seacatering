import 'package:get/get.dart';

import '../controllers/menu_available_controller.dart';

class MenuAvailableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuAvailableController>(() => MenuAvailableController());
  }
}
