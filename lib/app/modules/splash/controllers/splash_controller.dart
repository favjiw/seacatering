import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_service_controller.dart';

class SplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () async {
      final hasSeenOnboarding = await _storageService.hasSeenOnboarding();
      final isLoggedIn = _auth.currentUser != null;

      Get.log('Has seen onboarding: $hasSeenOnboarding');
      Get.log('Is logged in: $isLoggedIn');

      if (!hasSeenOnboarding) {
        Get.offAllNamed('/onboarding');
      } else if (!isLoggedIn) {
        Get.offAllNamed('/login');
      } else {
        await _checkUserRoleAndNavigate();
      }
    });
  }

  Future<void> _checkUserRoleAndNavigate() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final role = userDoc.data()?['role'] ?? 'user';
          Get.log('User role: $role');

          // Save role to local storage
          await _storageService.saveRole(role);

          // Navigate based on role
          if (role == 'admin') {
            Get.offAllNamed('/admin-dashboard');
          } else {
            Get.offAllNamed('/botnavbar');
          }
        } else {
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.log('Error checking user role: $e');
      Get.offAllNamed('/login');
    }
  }
}