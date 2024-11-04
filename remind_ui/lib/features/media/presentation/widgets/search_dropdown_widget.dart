// search_dropdown_widget.dart
import 'package:flutter/material.dart';

class SearchDropdown {
  static void showSearchDropdown(
      BuildContext context, TextEditingController searchController) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(
          100, 56, 0, 0), // Adjust position based on your layout
      items: [
        PopupMenuItem(
          child: SizedBox(
            width: 200, // Adjust width as needed
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search By keyword...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              print(searchController.text);
              searchController.clear();
              Navigator.pop(context);
            },
            child: const Text("Go"),
          ),
        ),
      ],
    );
  }
}
