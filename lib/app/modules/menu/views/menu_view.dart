import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuPageController> {
  const MenuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MenuView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MenuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
