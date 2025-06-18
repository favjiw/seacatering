import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;

  void toggle() {
    isObscure.value = !isObscure.value;
  }
  void toggleConfirm() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }

  //TODO: Implement SignupController
  final count = 0.obs;

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
    super.onClose();
  }

  void increment() => count.value++;
}
