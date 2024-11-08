import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/media_bloc.dart';
import '../bloc/media_event.dart';

class SearchDropdown {
  static void showSearchDropdown(
      BuildContext context, final TextEditingController searchController) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 56, 0, 0),
      items: [
        PopupMenuItem(
          enabled: false, // Disable selection for this item
          child: SizedBox(
            width: 200,
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
              context.read<MediaBloc>().add(
                    GetMediaByRemindEvent(searchController.text),
                  );
              // Trigger the callback
              searchController.clear();
              Navigator.pop(context); // Close the dropdown
            },
            child: const Text("Go"),
          ),
        ),
      ],
    );
  }
}
