//responsive
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AuthTextFormField extends StatelessWidget {
  AuthTextFormField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.onchanged,
      @required this.controller,
      this.validator});
  String hintText;
  Icon icon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Function(String) onchanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: .01.sw, vertical: .03.sh),
      child: TextFormField(
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return 'the value  is not valid';
              }
              return null;
            },
        controller: controller,
        onChanged: onchanged,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(.5),
          ),
          prefixIcon: icon,
          prefixIconColor: Colors.black.withOpacity(.5),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: const BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
        ),
      ),
    );
  }
}
