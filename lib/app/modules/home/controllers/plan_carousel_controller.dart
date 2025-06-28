import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanCarouselController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.64);
  final RxInt currentPlanIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPlanIndex.value = pageController.page?.round() ?? 0;
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}