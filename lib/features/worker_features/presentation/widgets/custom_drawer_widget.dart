// responsive
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomDrawerWidget extends StatelessWidget {
  CustomDrawerWidget(
      {super.key, required this.onTap, required this.path, required this.text});
  final String path;
  final String text;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              path,
              width: 30.w,
              height: 30.w,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
