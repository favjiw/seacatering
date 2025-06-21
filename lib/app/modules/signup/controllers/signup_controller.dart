import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController(text: "Favian");
  final emailController = TextEditingController(text: "mfavianj@gmail.com");
  final passwordController = TextEditingController(text: "12345678");
  final confirmPasswordController = TextEditingController(text: "12345678");

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void toggle() {
    isObscure.value = !isObscure.value;
  }
  void toggleConfirm() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Password dan konfirmasi tidak cocok");
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
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': usernameController.text.trim(),
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
          'role': "user"
        });
        Get.snackbar("Sukses", "Akun berhasil dibuat. Cek email untuk verifikasi!");
        Get.offAndToNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      String message = "";
      switch (e.code) {
        case 'email-already-in-use':
          message = "Email sudah digunakan";
          break;
        case 'invalid-email':
          message = "Format email tidak valid";
          break;
        case 'weak-password':
          message = "Password terlalu lemah";
          break;
        default:
          message = "Terjadi kesalahan: ${e.message}";
          print(e.message);
      }
      Get.snackbar("Gagal", message);
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
