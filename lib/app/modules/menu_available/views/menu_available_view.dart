import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../shared/constants/text_style.dart';
import '../../../shared/widgets/menu_item_widget.dart';
import '../controllers/menu_available_controller.dart';

class MenuAvailableView extends GetView<MenuAvailableController> {
  const MenuAvailableView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        titleTextStyle: AppTextStyle.appBarTitle,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: controller.menus.map((menu) {
                    return MenuItemWidget(
                      title: menu.name,
                      price: controller.formatPrice(menu.price),
                      image: menu.imageUrl,
                      onViewMore: () {
                        // Contoh navigasi detail
                        Get.toNamed('/menu-available-detail', arguments: menu);
                      },
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
