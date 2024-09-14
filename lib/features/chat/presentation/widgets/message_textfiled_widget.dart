import 'package:flutter/widgets.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:flutter/material.dart';

class MessageTextFieldWidget extends StatelessWidget {
  MessageTextFieldWidget(
      {super.key,
      required this.onSend,
      required this.textEditingController,
      required this.onsubmit});
  TextEditingController textEditingController;
  void Function(String)? onsubmit;
  Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        child: Row(children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.mainColor,
            child: Icon(Icons.add),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // onsubmit: onsubmit,
              onSubmitted: onsubmit,
              controller: textEditingController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Type a message',
                suffixIcon: IconButton(
                    onPressed: onSend,
                    icon: const Icon(
                      Icons.send,
                      color: MyColors.mainColor,
                    )),
              ),
            ),
          ))
        ]),
      ),
    );
  }
}