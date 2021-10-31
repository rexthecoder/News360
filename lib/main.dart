import 'package:flutter/material.dart';
import 'package:news360/src/app/intializer.dart';

import 'src/app/app.dart';

void main() async {
  await init();
  runApp(const App());
}
