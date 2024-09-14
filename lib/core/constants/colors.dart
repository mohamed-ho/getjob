import 'package:flutter/material.dart';

class MyColors {
  static const mainColor = Color(0xff4CA6A8);
  static const backgroundcolor = Color.fromARGB(255, 250, 247, 247);
  static const SenderMessageColor = Color.fromARGB(255, 197, 244, 245);
}

int colorFroHex(String colorHex) {
  return int.parse('0xff$colorHex');
}
