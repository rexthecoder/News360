import 'package:flutter/material.dart';
import 'src/app/intializer.dart';

import 'src/app/app_config.dart';

void main() async {
  await init();
  runApp(const App());
}
