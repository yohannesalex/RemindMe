import 'package:flutter/material.dart';

class ShowAdd {
  static Future<void> showDialog(BuildContext context) async {
    context:
    context;
    builder:
    (BuildContext context) {
      return AlertDialog(
        title: const Text("Terms and Privacy Policy"),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Terms of Service"),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Text("Privacy Policy"),
              SizedBox(height: 10),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Add"),
          ),
        ],
      );
    };
  }
}
