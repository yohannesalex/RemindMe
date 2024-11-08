import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/media_bloc.dart';
import '../bloc/media_event.dart';

class SearchDropdown {
  static void showSearchDropdown(
      BuildContext context, final TextEditingController searchController) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(60, 200, 200, 400),
      items: [
        PopupMenuItem(
          enabled: false, // Disable selection for this item
          child: SizedBox(
            width: 600,
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
              backgroundColor: const Color.fromARGB(255, 149, 181, 206),
            ),
            onPressed: () {
              context.read<MediaBloc>().add(
                    GetMediaByRemindEvent(searchController.text),
                  );
              // Trigger the callback
              searchController.clear();
              Navigator.pop(context); // Close the dropdown
            },
            child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 149, 181, 206),
                ),
                child: Center(child: Text("Go"))),
          ),
        ),
      ],
    );
  }
}
