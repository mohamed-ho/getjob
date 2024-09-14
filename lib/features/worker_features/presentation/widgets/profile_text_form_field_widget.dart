import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileTextFormField extends StatelessWidget {
  ProfileTextFormField(
      {super.key,
      required this.readOnly,
      required this.textController,
      required this.label,
      this.validator,
      this.hide = false});
  final bool readOnly;
  final String label;
  final TextEditingController textController;
  String? Function(String?)? validator;
  bool hide;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(.6)),
          ),
          TextFormField(
              obscureText: hide,
              validator: validator,
              readOnly: readOnly, // Makes the TextFormField non-editable

              controller: textController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0), // Color and width for the enabled border
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0),
                    borderRadius: BorderRadius.all(Radius.circular(9))),
              )),
        ],
      ),
    );
  }
}
