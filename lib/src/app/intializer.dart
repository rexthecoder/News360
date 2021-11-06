/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/authentication/auth_configuration.dart';
import 'package:news360/src/logic/authentication/authentication_controller.dart';
import 'package:news360/src/logic/logic.dart';
import 'package:news360/src/presentation/theme/theme.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  Loggy.initLoggy();
  configLoading();
// injecting the controller for auth state.
  Get.lazyPut<AuthenticationController>(
    () => AuthenticationController(
      AuthConfiguration(),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = isDarkMode ? EasyLoadingStyle.light : EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskColor = AppColors.purplePrimary.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}
