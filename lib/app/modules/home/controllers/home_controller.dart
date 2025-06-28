import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_service_controller.dart';
import '../../../data/PlanHome.dart';
import '../../../data/PlanModel.dart';
import '../../../data/Testimony.dart';
import '../../../data/TestimonyHome.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.64);
  final RxInt currentPlanIndex = 0.obs;
  final RxString address = ''.obs;
  // final RxList<HomeTestimony> testimonies = <HomeTestimony>[].obs;
  final isLoadingTestimonies = false.obs;

  late final Stream<QuerySnapshot> _testimoniesStream;
  final RxList<HomeTestimony> testimonies = <HomeTestimony>[].obs;

  Future<void> fetchTestimonies() async {
    try {
      isLoadingTestimonies.value = true;
      testimonies.clear();

      final snapshot = await FirebaseFirestore.instance
          .collection('testimonies')
          .where('is_approved', isEqualTo: true)
          .orderBy('created_at', descending: true)
          .limit(10)
          .get();

      testimonies.assignAll(snapshot.docs.map((doc) {
        final testimony = Testimony.fromFirestore(doc);
        return HomeTestimony.fromFirestoreTestimony(testimony);
      }));
    } catch (e) {
      Get.snackbar('Error', 'Failed to load testimonials');
    } finally {
      isLoadingTestimonies.value = false;
    }
  }

  void _setupTestimoniesStream() {
    _testimoniesStream = FirebaseFirestore.instance
        .collection('testimonies')
        .where('is_approved', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .limit(10)
        .snapshots();

    _testimoniesStream.listen((QuerySnapshot snapshot) {
      testimonies.assignAll(snapshot.docs.map((doc) {
        final testimony = Testimony.fromFirestore(doc);
        return HomeTestimony.fromFirestoreTestimony(testimony);
      }));
    }, onError: (error) {
      Get.snackbar('Error', 'Failed to load testimonials');
    });
  }

  final List<PlanHome> plans = [
    PlanHome(
      title: "Diet Plan",
      subtitle: "Low-calorie meals designed for healthy weight.",
      price: "Rp30.000/meal",
      imagePath: "assets/images/diet.png",
      badgeImagePath: "assets/images/gold.png",
    ),
    PlanHome(
      title: "Royal Plan",
      subtitle: "Premium meals, maximum variety and satisfaction.",
      price: "Rp60.000/meal",
      imagePath: "assets/images/royal.png",
      badgeImagePath: "assets/images/silver.png",
    ),
    PlanHome(
      title: "Protein Plan",
      subtitle: "High-protein meals to support muscle growth.",
      price: "Rp40.000/meal",
      imagePath: "assets/images/protein.png",
      badgeImagePath: "assets/images/bronze.png",
    ),
    PlanHome.empty(),
  ];

  Future<void> getAddress() async {
    final storageService = Get.find<StorageService>();
    final savedAddress = await storageService.getAddress();
    if (savedAddress != null) {
      address.value = savedAddress;
    } else {
      address.value = 'Set your address';
    }
  }

  void _updateCurrentIndex() {
    currentPlanIndex.value = pageController.page?.round() ?? 0;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    pageController.addListener(_updateCurrentIndex);
    getAddress();
    // fetchTestimonies();
    _setupTestimoniesStream();
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
