// dropdown_input_field.dart
import 'package:flutter/material.dart';

class DropdownInputField extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;

  const DropdownInputField({
    Key? key,
    required this.controller,
    required this.options,
  }) : super(key: key);

  @override
  _DropdownInputFieldState createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  void _showDropdown(BuildContext context) {
    showMenu(
      context: context,
      position:
          const RelativeRect.fromLTRB(0, 80, 0, 0), // Adjust position as needed
      items: widget.options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          widget.controller.text = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDropdown(context),
      child: AbsorbPointer(
        child: TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: 'Select an option',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}
