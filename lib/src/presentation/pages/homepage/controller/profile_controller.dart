import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class ProfileController extends GetxController with UiLoggy {
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
}
