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
