import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_service_controller.dart';
import '../../../data/PlanModel.dart';

class SubscriptionFormController extends GetxController {
  //TODO: Implement SubscriptionFormController
  TextEditingController allergieController = TextEditingController();
  TextEditingController moreController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final selectedPlan = Rx<PlanModel?>(null);
  var selectedMeals = <String>[].obs;
  final selectedDeliveryDays = <String>[].obs;
  final RxBool isMealTypeValid = true.obs;
  final RxBool isDeliveryDayValid = true.obs;
  final mealPlans = <PlanModel>[].obs;
  final isLoadingMealPlans = true.obs;

  List<String> mealOptions = ['Breakfast', 'Lunch', 'Dinner'];
  final deliveryDays = <String>[
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday'
  ];

  Future<void> fetchMealPlans() async {
    try {
      isLoadingMealPlans.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('meal_plans').get();

      mealPlans.value = snapshot.docs
          .map((doc) => PlanModel.fromMap(doc.data()))
          .toList();

      if (mealPlans.isNotEmpty) {
        selectedPlan.value = mealPlans.first;
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat meal plans: $e");
    } finally {
      isLoadingMealPlans.value = false;
    }
  }

  Future<void> getUsername() async {
    final storageService = Get.find<StorageService>();
    final savedUsername = await storageService.getUsername();
    if (savedUsername != null) {
      nameController.text = savedUsername;
    } else {
      nameController.text = 'Guest';
    }
  }

  Future<void> getPhone() async {
    final storageService = Get.find<StorageService>();
    final savedPhone = await storageService.getPhone();
    if (savedPhone != null) {
      phoneController.text = savedPhone;
    } else {
      phoneController.text = '0';
    }
  }

  bool validateCheckboxFields() {
    isMealTypeValid.value = selectedMeals.isNotEmpty;
    isDeliveryDayValid.value = selectedDeliveryDays.isNotEmpty;
    return isMealTypeValid.value && isDeliveryDayValid.value;
  }

  void setSelectedPlan(PlanModel plan) {
    selectedPlan.value = plan;
  }

  void toggleDeliveryDay(String day) {
    if (selectedDeliveryDays.contains(day)) {
      selectedDeliveryDays.remove(day);
    } else {
      selectedDeliveryDays.add(day);
    }
  }

  void toggleMeal(String meal) {
    if (selectedMeals.contains(meal)) {
      selectedMeals.remove(meal);
    } else {
      selectedMeals.add(meal);
    }
  }

  bool validateSelection() {
    return selectedMeals.isNotEmpty;
  }

  bool validateDeliveryDays() => selectedDeliveryDays.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    getUsername();
    fetchMealPlans();
    getPhone();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    allergieController.dispose();
    moreController.dispose();
    selectedMeals.clear();
    selectedDeliveryDays.clear();
    super.onClose();
  }
}