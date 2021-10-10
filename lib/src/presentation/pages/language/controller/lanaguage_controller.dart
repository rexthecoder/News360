import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class LanguageController extends GetxController with UiLoggy {
  Map<int, bool> selectedInterestFavorite = <int, bool>{0: true};

  void interestSelection(bool isSelected, int index) {
    // Avoid users from deactvating all lanaguage pref
    if (selectedInterestFavorite[index] == true) {
      logDebug('Atleast one lanaguage prefrence must be seleceted');
      return;
    }
    selectedInterestFavorite.updateAll((key, value) => false);

    selectedInterestFavorite[index] = !isSelected;
    update();
  }
}
