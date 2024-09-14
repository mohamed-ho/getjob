import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddJobTextFormField extends StatelessWidget {
  AddJobTextFormField({
    required this.controller,
    required this.label,
    required this.validator,
    super.key,
  });
  final String label;
  final TextEditingController controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white))),
      ),
    );
  }
}
