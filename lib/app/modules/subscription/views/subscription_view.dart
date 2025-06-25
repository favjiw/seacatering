import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constants/text_style.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
        titleTextStyle: AppTextStyle.appBarTitle,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('You Currently doest not have any subscription')),
          ElevatedButton(onPressed: (){
            Get.toNamed('/subscription-form');
          }, child: Text('Create Subscription'))
        ],
      ),
    );
  }
}
