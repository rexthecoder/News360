/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../../localization/localization_services.dart';
import '../../../../logic/global/lanaguages_list.dart';

class LanguageController extends GetxController with UiLoggy {
  Map<int, bool> selectedInterestFavorite = <int, bool>{0: true};
  bool? isSelected = false;

  // Handle slecetion
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

  // Track the selected card
  void trackSelected({
    required int index,
  }) {
    selectedInterestFavorite[index] = selectedInterestFavorite[index] ?? false;
    isSelected = selectedInterestFavorite[index];
  }

//Update the card
  void updateLanguageSelected({
    required int index,
  }) {
    interestSelection(isSelected!, index);
    LocalizationService().changeLocale(lanaguages[index]);
  }
}
