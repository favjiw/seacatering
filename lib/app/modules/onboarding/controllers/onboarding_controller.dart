import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController

  var pageIndex = 0.obs;
  late PageController pageController;

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Get.offAllNamed('/login');
  }

  void nextPage() async {
    if (pageIndex.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.log('set on boarding');
      completeOnboarding();
    }
  }

  void updatePageIndex(int index) {
    pageIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
