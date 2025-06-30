import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/storage_service_controller.dart';
import '../../../data/Testimony.dart';

class TestimonyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final messageController = TextEditingController();
  final RxInt rating = 1.obs;
  final isLoading = false.obs;
  final RxString username = ''.obs;

  late final String subscriptionId;
  late final String planId;
  late final String planName;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _loadUsername();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    subscriptionId = args['subscriptionId']?.toString() ?? '';
    planId = args['planId']?.toString() ?? '';
    planName = args['planName']?.toString() ?? 'Unknown Plan';

    if (subscriptionId.isEmpty || planId.isEmpty) {
      Get.back();
      Get.snackbar('Error', 'Invalid subscription data');
    }
  }

  Future<void> _loadUsername() async {
    try {
      final storageService = Get.find<StorageService>();
      username.value = await storageService.getUsername() ?? 'Guest';
      nameController.text = username.value;
    } catch (e) {
      username.value = 'Guest';
      nameController.text = 'Guest';
      Get.snackbar('Notice', 'Using default username');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> submitTestimony() async {
    try {
      if (!_validateForm()) return;

      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      if (await _hasExistingTestimony(user.uid)) {
        throw Exception("You already submitted testimony for this subscription");
      }

      final testimony = Testimony(
        userId: user.uid,
        userName: nameController.text.trim(),
        subscriptionId: subscriptionId,
        planId: planId,
        planName: planName,
        rating: rating.value,
        message: messageController.text.trim(),
        createdAt: DateTime.now(),
      );

      await _saveTestimony(testimony);
      await _updateSubscriptionStatus();

      Get.back();
      Get.snackbar('Success', 'Testimony submitted successfully!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (!formKey.currentState!.validate()) return false;
    if (rating.value < 1) {
      Get.snackbar('Error', 'Please select a rating');
      return false;
    }
    return true;
  }


  Future<bool> _hasExistingTestimony(String userId) async {
    final query = await FirebaseFirestore.instance
        .collection('testimonies')
        .where('user_id', isEqualTo: userId)
        .where('subscription_id', isEqualTo: subscriptionId)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }

  Future<void> _saveTestimony(Testimony testimony) async {
    final docRef = await FirebaseFirestore.instance
        .collection('testimonies')
        .add(testimony.toFirestore());

    await docRef.update({'id': docRef.id});
  }

  Future<void> _updateSubscriptionStatus() async {
    await FirebaseFirestore.instance
        .collection('subscriptions')
        .doc(subscriptionId)
        .update({'has_testimony': true});
  }
}