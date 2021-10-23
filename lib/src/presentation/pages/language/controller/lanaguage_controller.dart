import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/localization/localization_services.dart';
import 'package:news360/src/logic/global/lanaguages_list.dart';

class LanguageController extends GetxController with UiLoggy {
  Map<int, bool> selectedInterestFavorite = <int, bool>{0: true};
  bool? isSelected = false;

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

  void trackSelected({
    required int index,
  }) {
    selectedInterestFavorite[index] = selectedInterestFavorite[index] ?? false;
    isSelected = selectedInterestFavorite[index];
  }

  void updateLanguageSelected({
    required int index,
  }) {
    interestSelection(isSelected!, index);
    LocalizationService().changeLocale(lanaguages[index]);
  }
}
