import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_service_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final storageService = Get.find<StorageService>();
  final RxString username = ''.obs;
  final RxString email = ''.obs;

  Future<void> getUsername() async {
    final storageService = Get.find<StorageService>();
    final savedUsername = await storageService.getUsername();
    if (savedUsername != null) {
      username.value = savedUsername;
    } else {
      username.value = 'Guest';
    }
  }

  Future<void> getEmail() async {
    final storageService = Get.find<StorageService>();
    final savedEmail = await storageService.getEmail();
    if (savedEmail != null) {
      email.value = savedEmail;
    } else {
      email.value = 'Guest@gmail.com';
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Logout Error', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUsername();
    getEmail();
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
