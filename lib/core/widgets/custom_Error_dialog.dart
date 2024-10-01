import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';

customErrorDialog(BuildContext context, String dialogBody, String dialogTitle) {
  AwesomeDialog(
          context: context,
          body: Text(dialogBody),
          title: dialogTitle,
          dialogType: DialogType.error)
      .show();
}

customCorrectDialog(
    BuildContext context, String dialogBody, String dialogTitle) {
  AwesomeDialog(
    context: context,
    body: Text(
      dialogBody,
      style: const TextStyle(fontSize: 16, color: MyColors.mainColor),
    ),
    title: dialogTitle,
    dialogType: DialogType.success,
  ).show();
}
