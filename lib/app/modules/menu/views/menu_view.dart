import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../shared/constants/text_style.dart';
import '../../../shared/widgets/menu_item_widget.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuPageController> {
  const MenuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        titleTextStyle: AppTextStyle.appBarTitle,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ],
        ),),
      ),
    );
  }
}
