import 'package:get/get.dart';

import '../controllers/subscription_form_controller.dart';

class SubscriptionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionFormController>(
      () => SubscriptionFormController(),
    );
  }
}
