//responsive
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AuthPasswordTextFormField extends StatefulWidget {
  AuthPasswordTextFormField(
      {super.key,
      required this.hintText,
      required this.onChange,
      @required this.controller,
      required this.validator});
  String hintText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Function(String) onChange;
  @override
  State<AuthPasswordTextFormField> createState() =>
      _AuthPasswordTextFormFieldState();
}

class _AuthPasswordTextFormFieldState extends State<AuthPasswordTextFormField> {
  bool hidenText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onChange,
      obscureText: hidenText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.lock),
        suffixIconColor: Colors.black.withOpacity(.5),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidenText = !hidenText;
            });
          },
          icon: hidenText
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility_outlined),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(.5),
        ),
        prefixIconColor: Colors.black.withOpacity(.5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.w),
            borderSide: const BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
      ),
    );
  }
}
