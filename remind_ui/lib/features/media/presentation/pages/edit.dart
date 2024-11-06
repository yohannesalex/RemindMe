import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/presentation/bloc/media_bloc.dart';
import 'package:remind_ui/features/media/presentation/bloc/media_event.dart';

import '../../../authentication/presentation/widget/snackbar.dart';
import '../bloc/media_state.dart';

class Edit extends StatefulWidget {
  final TextEditingController _textController;
  final TextEditingController _linkController;
  final TextEditingController _categoryController;
  final TextEditingController _keywordController;
  final String imageUrl;
  final String text;
  final String link;
  final String category;
  final String remindBy;
  final String id;
  Edit(
      {super.key,
      required this.id,
      this.imageUrl = '',
      this.text = '',
      this.link = '',
      this.category = '',
      this.remindBy = ''})
      : _categoryController = TextEditingController(text: category),
        _textController = TextEditingController(text: text),
        _linkController = TextEditingController(text: link),
        _keywordController = TextEditingController(text: remindBy);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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
    return BlocListener<MediaBloc, MediaState>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          context.read<MediaBloc>().add(LoadAllMediaEvent());
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is ErrorState) {
          SnackBarHelper.showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 242, 189, 172),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined,
                color: Color.fromARGB(255, 52, 48, 70)),
          ),
          actions: const [
            Text(
              "Edit Media",
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
                            const Center(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                                  child: Text("Chage Image")),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.grey[200],
                              ),
                              child: _image != null
                                  ? Image.file(_image!, fit: BoxFit.cover)
                                  : widget.imageUrl != ''
                                      ? Image.network(
                                          "http://192.168.104.42:5244${widget.imageUrl}",
                                          fit: BoxFit.cover,
                                        )
                                      : const Center(
                                          child: Text('No image selected')),
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
                            controller: widget._textController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          _buildTextField(
                            label: 'Link',
                            hint: 'ex: http://www.google.com',
                            controller: widget._linkController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          _buildTextField(
                              label: "Keyword to remind",
                              hint: "ex: That black guy",
                              controller: widget._keywordController),
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

                              controller: widget._categoryController,
                              decoration: const InputDecoration(
                                labelText: "Select Category",
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true, // Prevents manual text input
                              onTap: () {
                                _showDropdown(
                                    context, widget._categoryController);
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
                      if (widget._textController.text.isEmpty &&
                          widget._linkController.text.isEmpty &&
                          _image == null) {
                        SnackBarHelper.showCustomSnackBar(context,
                            'You need to required to fill at least one field');
                        return;
                      } else if (widget._categoryController.text.isEmpty) {
                        SnackBarHelper.showCustomSnackBar(
                            context, 'Please select a category');

                        return;
                      } else {
                        context.read<MediaBloc>().add(UpdateMediaEvent(
                            MediaEntity(
                                id: widget.id,
                                userId: '',
                                text: widget._textController.text,
                                link: widget._linkController.text,
                                remindBy: widget._keywordController.text,
                                category: widget._categoryController.text,
                                imageUrl: _image?.path ?? '',
                                createdAt: '')));
                        context.read<MediaBloc>().add(LoadAllMediaEvent());
                      }
                    },
                    child: const Text('Edit '),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
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
