import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kazakh_invest/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}
