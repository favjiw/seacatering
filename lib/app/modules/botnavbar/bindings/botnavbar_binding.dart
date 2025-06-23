import 'package:get/get.dart';

import '../controllers/botnavbar_controller.dart';

class BotnavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BotnavbarController>(
      () => BotnavbarController(),
    );
  }
}
