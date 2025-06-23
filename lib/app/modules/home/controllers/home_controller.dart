import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/PlanModel.dart';
import '../../../data/Testimony.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.64);
  final RxInt currentPlanIndex = 0.obs;

  final List<Testimony> testimonies = [
    Testimony(
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
      userName: "Zaki",
      planName: "Royal Plan",
      rating: 4,
    ),
    Testimony(
      content: "Very satisfied with the meal plans...",
      userName: "Sarah",
      planName: "Diet Plan",
      rating: 5,
    ),
    Testimony(
      content: "Good service and delicious food...",
      userName: "John",
      planName: "Protein Plan",
      rating: 3,
    ),
  ];

  final List<PlanModel> plans = [
    PlanModel(
      title: "Diet Plan",
      subtitle: "Low-calorie meals designed for healthy weight.",
      price: "Rp30.000/meal",
      imagePath: "assets/images/diet.png",
      badgeImagePath: "assets/images/gold.png",
    ),
    PlanModel(
      title: "Royal Plan",
      subtitle: "Premium meals, maximum variety and satisfaction.",
      price: "Rp60.000/meal",
      imagePath: "assets/images/royal.png",
      badgeImagePath: "assets/images/silver.png",
    ),
    PlanModel(
      title: "Protein Plan",
      subtitle: "High-protein meals to support muscle growth.",
      price: "Rp40.000/meal",
      imagePath: "assets/images/protein.png",
      badgeImagePath: "assets/images/bronze.png",
    ),
    PlanModel.empty(),
  ];

  void _updateCurrentIndex() {
    currentPlanIndex.value = pageController.page?.round() ?? 0;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    pageController.addListener(_updateCurrentIndex);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.removeListener(_updateCurrentIndex);
    pageController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
