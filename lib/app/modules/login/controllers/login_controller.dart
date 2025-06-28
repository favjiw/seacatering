import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_service_controller.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final storageService = Get.find<StorageService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isObscure = true.obs;

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        if (doc.exists) {
          // Get user data
          final fullName = doc.data()?['username'] ?? '';
          final userEmail = doc.data()?['email'] ?? '';
          final role = doc.data()?['role'] ?? 'user'; // Default to 'user'

          // Save user data using StorageService
          await storageService.saveUsername(fullName);
          await storageService.saveEmail(userEmail);
          await storageService.saveRole(role); // Using the new saveRole method

          Get.log('User logged in: $fullName');
          Get.log('Role: $role');

          // Navigate based on role
          if (role == 'admin') {
            Get.offAllNamed('/admin-dashboard');
          } else {
            Get.offAllNamed('/botnavbar');
          }
        } else {
          throw Exception('User document not found');
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Failed',
        _getErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onError,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onError,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Email format is invalid.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return e.message ?? 'Authentication error.';
    }
  }

  void toggle() {
    isObscure.value = !isObscure.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
