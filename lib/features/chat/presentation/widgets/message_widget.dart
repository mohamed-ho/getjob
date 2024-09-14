import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget(
      {super.key,
      required this.isSender,
      required this.messageContant,
      required this.messageTime});
  bool isSender;
  String messageContant;
  String messageTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: isSender ? MyColors.SenderMessageColor : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: isSender ? const Radius.circular(20) : Radius.zero,
                topRight: isSender ? Radius.zero : const Radius.circular(20),
                bottomLeft: const Radius.circular(20),
                bottomRight: const Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                messageContant,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(messageTime),
            )
          ]),
        ),
      ),
    );
  }
}
