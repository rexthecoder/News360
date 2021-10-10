import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class FavoriteController extends GetxController
    with SingleGetTickerProviderMixin, UiLoggy {
  Map<int, bool> selectedInterestFavorite = <int, bool>{0: true};

  void interestSelection(bool isSelected, int index) {
    // selectedInterestFavorite
    //     .updateAll((key, value) => selectedInterestFavorite[index]!);
    selectedInterestFavorite[index] = !isSelected;

    update();
  }

 
}
