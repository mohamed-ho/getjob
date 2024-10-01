import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onpressed, required this.textChild});
  final Function() onpressed;
  final String textChild;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.mainColor,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          textChild,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
