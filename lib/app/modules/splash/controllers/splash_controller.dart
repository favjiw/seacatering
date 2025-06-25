import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_service_controller.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final StorageService _storageService = StorageService();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () async {
      final hasSeenOnboarding = await _storageService.hasSeenOnboarding();
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      Get.log(hasSeenOnboarding.toString() );
      Get.log(isLoggedIn.toString());
      if (!hasSeenOnboarding) {
        Get.offAllNamed('/onboarding');
      } else if (!isLoggedIn) {
        Get.offAllNamed('/login');
      } else {
        Get.offAllNamed('/botnavbar');
      }

    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
