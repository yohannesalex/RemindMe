import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/presentation/bloc/media_bloc.dart';
import 'package:remind_ui/features/media/presentation/bloc/media_event.dart';

import '../../../authentication/presentation/widget/snackbar.dart';
import '../bloc/media_state.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _keywordController = TextEditingController();
  final List<String> _options = [
    'Family',
    'School',
    'Friends',
    'Stranger',
    'Transport',
    'Work',
    'Other'
  ];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 189, 172),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back_ios_outlined,
                color: Color.fromARGB(255, 52, 48, 70)),
          ),
        ),
        actions: const [
          Text(
            "Add Media",
            style: TextStyle(
              color: Color.fromARGB(255, 52, 48, 70),
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: BlocListener<MediaBloc, MediaState>(
        listener: (context, state) {
          if (state is SuccessState) {
            context.read<MediaBloc>().add(LoadAllMediaEvent());
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is ErrorState) {
            SnackBarHelper.showCustomSnackBar(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 242, 242),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                              child: Text("Upload Image")),
                          Container(
                            margin: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[200],
                            ),
                            child: _image == null
                                ? const Center(child: Text('No image selected'))
                                : Image.file(_image!, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.photo_library),
                                  label: const Text('Browse'),
                                  onPressed: () =>
                                      _pickImage(ImageSource.gallery),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.camera_alt),
                                  label: const Text('Camera'),
                                  onPressed: () =>
                                      _pickImage(ImageSource.camera),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                          label: 'Text',
                          hint: 'ex: there is a shop in 3rd floor',
                          controller: _textController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                          label: 'Link',
                          hint: 'ex: http://www.google.com',
                          controller: _linkController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                            label: "Keyword to remind",
                            hint: "ex: That black guy",
                            controller: _keywordController),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          " Category",
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),

                            controller: _categoryController,
                            decoration: const InputDecoration(
                              labelText: "Select Category",
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true, // Prevents manual text input
                            onTap: () {
                              _showDropdown(context, _categoryController);
                            },
                          ),
                        ),
                      ]),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 187, 214, 238),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                  ),
                  onPressed: () {
                    if (_textController.text.isEmpty &&
                        _linkController.text.isEmpty &&
                        _image == null) {
                      SnackBarHelper.showCustomSnackBar(context,
                          'You need to required to fill at least one field');
                      return;
                    } else if (_categoryController.text.isEmpty) {
                      SnackBarHelper.showCustomSnackBar(
                          context, 'Please select a category');

                      return;
                    } else {
                      context.read<MediaBloc>().add(CreateMediaEvent(
                          MediaEntity(
                              id: '',
                              userId: '',
                              text: _textController.text,
                              link: _linkController.text,
                              remindBy: _keywordController.text,
                              category: _categoryController.text,
                              imageUrl: _image?.path ?? '',
                              createdAt: '')));
                      print(
                          '/////////////////////////////////////////????????');
                      print(_textController);
                      print(_linkController);
                    }
                  },
                  child: const Text('Add '),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context, TextEditingController controller) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        offset.dy,
      ),
      items: _options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          controller.text = value;
        });
      }
    });
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: 350,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 90, 1, 1),
                    width: 0.1,
                  ),
                ),
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 111, 107, 107),
                ),
                errorStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
