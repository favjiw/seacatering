import 'package:get/get.dart';

import '../controllers/testimony_controller.dart';

class TestimonyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestimonyController>(
      () => TestimonyController(),
    );
  }
}
