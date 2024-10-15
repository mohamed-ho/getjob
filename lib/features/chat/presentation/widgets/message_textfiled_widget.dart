import 'package:getjob/core/constants/colors.dart';
import 'package:flutter/material.dart';

class MessageTextFieldWidget extends StatelessWidget {
  const MessageTextFieldWidget(
      {super.key,
      required this.onSend,
      required this.textEditingController,
      required this.onsubmit,
      required this.onChange});
  final TextEditingController textEditingController;
  final void Function(String)? onsubmit;
  final Function() onSend;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            // onsubmit: onsubmit,
            onChanged: onChange,
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
    );
  }
}
