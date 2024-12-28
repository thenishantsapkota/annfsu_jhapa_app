import 'package:get/get.dart';
import 'package:flutter/material.dart';

generateSuccessSnackbar(String title, String message) {
  Get.snackbar(
    '',
    '',
    titleText: Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    borderRadius: 12,
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

generateErrorSnackbar(String title, String message) {
  Get.snackbar(
    '',
    '',
    titleText: Row(
      children: [
        const Icon(Icons.error, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    borderRadius: 12,
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
