import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class SnackBarHelper {
  static Future<void> showCustomSnackBar(
      BuildContext context, String message) async {
    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }

    // Show SnackBar with red background
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red, // Set the background color to red
        duration: const Duration(seconds: 2), // Customize duration
      ),
    );
  }
}
