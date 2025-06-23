import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscriptionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscriptionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
