import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/storage_service_controller.dart';

class SignupController extends GetxController {
  final storageService = Get.find<StorageService>();
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final roleController = TextEditingController(text: 'user');

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'ID');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> completeSign() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    final role = await storageService.getRole();
    if (role == 'admin') {
      Get.offAllNamed('/admin-dashboard');
    } else {
      Get.offAllNamed('/botnavbar');
    }
  }

  void toggle() => isObscure.value = !isObscure.value;
  void toggleConfirm() => isConfirmObscure.value = !isConfirmObscure.value;

  bool validatePhone(String phone) {
    if (phone.isEmpty) return false;

    try {
      final parsed = PhoneNumber.getRegionInfoFromPhoneNumber(phone);
      return parsed != null;
    } catch (e) {
      return false;
    }
  }


  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    if (!validatePhone(phoneController.text.trim())) {
      Get.snackbar("Error", "Please enter a valid phone number");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Password and confirmation do not match");
      return;
    }

    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        final userData = {
          'uid': user.uid,
          'username': usernameController.text.trim(),
          'email': user.email,
          'phone': phoneController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'role': roleController.text.trim(),
          'emailVerified': false,
        };

        await _firestore.collection('users').doc(user.uid).set(userData);

        await storageService.saveUsername(usernameController.text.trim());
        await storageService.saveEmail(user.email ?? '');
        await storageService.savePhone(phoneController.text.trim());
        await storageService.saveRole(roleController.text.trim());

        await user.sendEmailVerification();

        usernameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        isObscure.value = true;
        isConfirmObscure.value = true;

        Get.snackbar(
          "Success",
          "Account created successfully! Please check your email for verification.",
          snackPosition: SnackPosition.BOTTOM,
        );

        completeSign();
      }
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return "This email is already registered";
      case 'invalid-email':
        return "Please enter a valid email address";
      case 'weak-password':
        return "Password must be at least 6 characters";
      case 'operation-not-allowed':
        return "Email/password accounts are not enabled";
      case 'too-many-requests':
        return "Too many requests. Please try again later";
      default:
        return "Authentication failed. Please try again";
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    roleController.dispose();
    super.onClose();
  }
}