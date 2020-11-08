import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 25,
      child: Platform.isAndroid
          ? const CircularProgressIndicator(
              strokeWidth: 2,
            )
          : const CupertinoActivityIndicator(
              radius: 15,
            ),
    );
  }
}
