import 'package:flutter/material.dart';

class CustomButtonNavigationBarIcon extends StatelessWidget {
  const CustomButtonNavigationBarIcon(
      {super.key,
      required this.icon,
      required this.discreption,
      required this.onTap});
  final Widget discreption;
  final Function() onTap;

  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        icon,
        discreption,
      ]),
    );
  }
}
