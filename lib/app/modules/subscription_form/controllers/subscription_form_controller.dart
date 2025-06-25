import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionFormController extends GetxController {
  //TODO: Implement SubscriptionFormController
  TextEditingController allergieController = TextEditingController();
  TextEditingController moreController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final selectedPlan = 'Diet'.obs;
  var selectedMeals = <String>[].obs;
  final selectedDeliveryDays = <String>[].obs;
  final RxBool isMealTypeValid = true.obs;
  final RxBool isDeliveryDayValid = true.obs;



  List<String> mealOptions = ['Breakfast', 'Lunch', 'Dinner'];
  final deliveryDays = <String>[
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday'
  ];

  final count = 0.obs;


  bool validateCheckboxFields() {
    isMealTypeValid.value = selectedMeals.isNotEmpty;
    isDeliveryDayValid.value = selectedDeliveryDays.isNotEmpty;
    return isMealTypeValid.value && isDeliveryDayValid.value;
  }

  void setSelectedPlan(String plan) {
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
