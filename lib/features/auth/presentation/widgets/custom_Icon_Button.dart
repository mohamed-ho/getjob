import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.iconPath, required this.onpressed});
  final String iconPath;
  final Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.w),
      onTap: onpressed,
      child: Image.asset(
        iconPath,
        fit: BoxFit.fill,
      ),
    );
  }
}
