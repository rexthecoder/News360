import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/authentication/authentication_controller.dart';
import 'package:news360/src/logic/global/variables.dart';

class ProfileController extends GetxController with UiLoggy {
  AuthenticationController auth = Get.find();

  // Method for routing to a diffrent screen
  void navigateToNextScreen(int index) {
    logDebug('Track:: $index');
    var _path = switchRoutes(index);
    Get.toNamed(_path);
  }

  // Method to track the page we should navigate to
  String switchRoutes(int index) {
    switch (index) {
      case 0:
        return 'language';
      case 1:
        return 'changePassword';
      case 2:
        return 'privacy';
      case 3:
        return 'terms';
      default:
        logError('$index has no route path attached to it');
        return 'home';
    }
  }

  //Handle sign out
  Future<void> handleSignOut(context) async {
    isPointerAbsorbing.value = true;
    processSignOut(context);
  }

  //Process sign out
  Future<void> processSignOut(context) async {
    final progress = ProgressHUD.of(context);
    progress?.showWithText('Signing out...');
    Future.delayed(const Duration(seconds: 3), () {
      auth.signOut();
      progress?.dismiss();
      isPointerAbsorbing.value = false;
      Get.toNamed('login', arguments: false);
    });
  }
}
