import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final int maxLines;
  final int minLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        // style: const TextStyle(fontSize: 20),
        controller: controller,
        validator: (val) => val!.isEmpty ? '$hintText Can\'t be empty' : null,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }
}