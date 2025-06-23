import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:seacatering/app/shared/constants/colors.dart';

import '../../contact/views/contact_view.dart';
import '../../home/views/home_view.dart';
import '../../menu/views/menu_view.dart';
import '../../subscription/views/subscription_view.dart';
import '../controllers/botnavbar_controller.dart';



// Tambahkan import controller secara eksplisit
import '../../home/controllers/home_controller.dart';

class BotnavbarView extends GetView<BotnavbarController> {
  const BotnavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    // Bind controller secara manual (hanya sekali)
    Get.lazyPut(() => HomeController(), fenix: true);
    final List<Widget> pages = const [
      HomeView(),
      MenuView(),
      SubscriptionView(),
      ContactView(),
    ];

    return Obx(() => Scaffold(
      body: pages[controller.currentIndex.value],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: GNav(
          gap: 5,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          color: AppColors.gray,
          activeColor: AppColors.white,
          tabBackgroundColor: AppColors.primary,
          selectedIndex: controller.currentIndex.value,
          onTabChange: controller.changePage,
          tabs: [
            GButton(icon: Icons.home_rounded, text: 'Home'),
            GButton(icon: Icons.restaurant_menu_rounded, text: 'Menu'),
            GButton(icon: Icons.subscriptions_rounded, text: 'Subscription'),
            GButton(icon: Icons.contact_phone_rounded, text: 'Contact'),
          ],
        ),
      ),
    ));
  }
}
