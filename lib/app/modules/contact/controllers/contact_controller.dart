import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {
  final phoneNumber = '+628123456789'.obs;
  final justCopied = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> copyPhoneNumber() async {
    await Clipboard.setData(ClipboardData(text: phoneNumber.value));
    justCopied.value = true;
    Get.snackbar(
      'Copied!',
      'Phone number copied to clipboard',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
    await Future.delayed(Duration(seconds: 2));
    justCopied.value = false;
  }

  Future<void> contactViaWhatsApp() async {
    final phone = phoneNumber.value;

    // Validate phone number
    if (phone.isEmpty || !phone.startsWith('+')) {
      Get.snackbar(
        'Invalid Number',
        'Please provide a valid international phone number',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final message = 'Hello, I would like to inquire about SEA Catering';
    final url = 'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
