/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:get/get.dart';
import 'package:news360/src/logic/authentication/auth_configuration.dart';
import 'package:news360/src/logic/authentication/authentication_controller.dart';

void init() {
// injecting the controller for auth state.
  Get.lazyPut<AuthenticationController>(
    () => AuthenticationController(
      AuthConfiguration(),
    ),
  );
}
