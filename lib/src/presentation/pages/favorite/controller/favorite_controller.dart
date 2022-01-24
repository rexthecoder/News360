/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../../logic/logic.dart';

class FavoriteController extends GetxController
    with SingleGetTickerProviderMixin, UiLoggy {
  // local vairable
  final DataBaseService _databaseService = DataBaseService();
  final Map<int, bool> _selectedInterestFavorite = <int, bool>{0: true};
  final _addFavourite = <String, String>{'0': categories[0]};

//Getters
  Map<int, bool> get selectedInterestFavorite => _selectedInterestFavorite;

//tracking selected favorite
  void interestSelection(bool isSelected, int index) {
    _selectedInterestFavorite[index] = !isSelected;
    _addFavourite['$index'] = categories[index];
    update();
  }

  //add favriote to the database
  void addToDataBase(context) {
    _databaseService.addCategory(
      _addFavourite,
      context: context,
    );
  }

  //return the selected reults
  bool? selected(int index) {
    selectedInterestFavorite[index] = selectedInterestFavorite[index] ?? false;
    bool? isSelected = selectedInterestFavorite[index];
    return isSelected;
  }
}
