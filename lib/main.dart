import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:loggy/loggy.dart';
import 'package:news360/src/app/intializer.dart';

import 'src/app/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  Loggy.initLoggy();
  init();
  await Firebase.initializeApp();

  runApp(App(settingsController: settingsController));
}
