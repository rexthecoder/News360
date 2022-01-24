import 'package:flutter/material.dart';

import 'src/app/app_config.dart';
import 'src/app/intializer.dart';

void main() async {
  await init();
  runApp(const App());
}
