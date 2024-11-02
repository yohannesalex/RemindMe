import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remind_ui/features/authentication/presentation/widget/add.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _date = DateFormat('MMMM d, yyyy').format(DateTime.now());
  final TextEditingController _searchController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Handle any specific logic when the state changes, if needed
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 242, 189, 172),
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: PopupMenuButton<String>(
                icon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 52, 48, 70),
                ),
                onSelected: (value) {
                  if (value == 'Log Out') {
                    context.read<AuthBloc>().add(LogOutEvent());
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'Log Out',
                      child: Text('Log Out'),
                    ),
                  ];
                },
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    _date,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 52, 48, 70),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Text(
                      'Hello, ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 52, 48, 70), fontSize: 15),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is GetMeSuccessState) {
                          return Text(
                            state.user.name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 8, 3, 91),
                              fontSize: 15,
                            ),
                          );
                        } else {
                          return const Text('User');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Show the filter menu programmatically
                  showMenu<String>(
                    context: context,
                    position: const RelativeRect.fromLTRB(100, 56, 0, 0),
                    items: [
                      const PopupMenuItem(
                          value: 'Family', child: Text('Family')),
                      const PopupMenuItem(
                          value: 'Friends', child: Text('Friends')),
                      const PopupMenuItem(
                          value: 'School', child: Text('School')),
                      const PopupMenuItem(
                          value: 'Stranger', child: Text('Stranger')),
                      const PopupMenuItem(value: 'Home', child: Text('Home')),
                      const PopupMenuItem(
                          value: 'Transport', child: Text('Transport')),
                      const PopupMenuItem(value: 'Work', child: Text('Work')),
                      const PopupMenuItem(value: 'Other', child: Text('Other')),
                    ],
                  );
                },
                child: const Text('Filter By'),
              ),
              IconButton(
                icon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 52, 48, 70)),
                onPressed: () {
                  // Show the search input field in a dropdown
                  _showSearchDropdown(context);
                },
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Color.fromARGB(255, 52, 48, 70),
                ),
                onSelected: (value) {
                  if (value == 'Add data') {
                    _showAddDialog();
                  } else if (value == 'Delete data') {
                    print('Delete data');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'Add data',
                      child: Text('Add data'),
                    ),
                    const PopupMenuItem(
                      value: 'Delete data',
                      child: Text('Delete data'),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            color: Color(0xFFFFEBEE),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome to the Home Page'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSearchDropdown(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(
          100, 56, 0, 0), // Adjust position based on your layout
      items: [
        PopupMenuItem(
          child: SizedBox(
            width: 200, // Adjust width as needed
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        // Spacing between input and options
        PopupMenuItem(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              print(_searchController.text);
              _searchController.clear();
              Navigator.pop(context);
            },
            child: const Text("Go"),
          ),
        ),
        // You can add more PopupMenuItems for additional options here
      ],
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Privacy Policy"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  width: double.infinity,
                  height: 120,
                  color: const Color(0xFFF3F3F3),
                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              ),
                              onPressed: _pickImage,
                            ),
                            const Text('Upload Image')
                          ],
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
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
      },
    );
  }
}
