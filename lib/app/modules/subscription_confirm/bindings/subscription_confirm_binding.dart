import 'package:get/get.dart';

import '../controllers/subscription_confirm_controller.dart';

class SubscriptionConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionConfirmController>(
      () => SubscriptionConfirmController(),
    );
  }
}
