import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/custom_dialog.dart';
import 'package:kazakh_invest/src/core/data/models/dialog_type.dart';

Future<bool> displayCustomDialog(
  BuildContext context,
  String _title,
  DialogType dialogType,
  bool barrierDismissible,
  Widget containerWidget,
  Function dofunc, [
  String negativeText,
  String positiveText,
]) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => CustomActionDialog(
      title: _title,
      dialogType: dialogType,
      container: containerWidget,
      onPressed: dofunc,
      cancelOptionText: negativeText,
      confirmOptionText: positiveText,
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

// setTextApp(String txt,){
//    switch (val) {
//     case "ru":
//       return "RUS";
//       break;
//     case "en":
//       return "ENG";
//       break;
//     case "kz":
//       return "KAZ";
//       break;
//     default:
//       break;
//   }
// }
