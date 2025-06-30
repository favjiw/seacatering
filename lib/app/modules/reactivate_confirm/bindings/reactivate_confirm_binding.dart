import 'package:get/get.dart';

import '../controllers/reactivate_confirm_controller.dart';

class ReactivateConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReactivateConfirmController>(
      () => ReactivateConfirmController(),
    );
  }
}
