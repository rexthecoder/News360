import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/database/database.dart';
import 'package:news360/src/logic/global/categories.dart';

class FavoriteController extends GetxController
    with SingleGetTickerProviderMixin, UiLoggy {
  final DataBaseService _databaseService = DataBaseService();
  Map<int, bool> selectedInterestFavorite = <int, bool>{0: true};
  var addFavourite = <String, String>{};

  void interestSelection(bool isSelected, int index) {
    // selectedInterestFavorite
    //     .updateAll((key, value) => selectedInterestFavorite[index]!);
    selectedInterestFavorite[index] = !isSelected;
    addFavourite['$index'] = categories[index];
    update();
  }

  void addToDataBase(context) {
    _databaseService.addCategory(
      addFavourite,
      context: context,
    );
  }
}
