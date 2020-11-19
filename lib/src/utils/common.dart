import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/custom_dialog.dart';
import 'package:kazakh_invest/src/core/data/models/dialog_type.dart';

Future<bool> displayCustomDialog(
  BuildContext context,
  String _title,
  DialogType dialogType,
  bool barrierDismissible,
  Widget containerWidget,
  String link,
  Function dofunc,
) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => CustomActionDialog(
      title: _title,
      dialogType: dialogType,
      container: containerWidget,
      onPressed: dofunc,
      link: link,
    ),
  );
}

setLangType(String val) {
  switch (val) {
    case "ru":
      return "RUS";
      break;
    case "en":
      return "ENG";
      break;
    case "kz":
      return "KAZ";
      break;
    default:
      break;
  }
}
