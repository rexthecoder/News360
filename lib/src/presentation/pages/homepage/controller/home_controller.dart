import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../../../logic/authentication/authentication_controller.dart';
import '../../../../logic/authentication/authentication_state.dart';
import '../../../../logic/global/categories.dart';
import '../../../../logic/global/variables.dart';
import '../../../../logic/scrapper/apps_scrapper.dart';

class HomeController extends GetxController
    with SingleGetTickerProviderMixin, UiLoggy {
  // Local Variables
  final RxInt _selectedPosition = 0.obs;
  final Scrapper _scrapper = Scrapper();
  Stream<FileResponse>? fileStream;
  var headline = [];
  var headlineList = [];
  RxString selectedCategory = 'Random'.obs;
  var newsList = [];
  AuthenticationController authcontroller = Get.find();

  Map<int, bool> selectedInterestFavorite = <int, bool>{0: true};
  final _sliderController = PageController(
    viewportFraction: 1,
  );
  final screenHieght = Get.height;
  final totalPage = 4;
  final _currentPage = 0.obs;

  // Getters
  RxInt get selectedPosition => _selectedPosition;
  PageController get sliderController => _sliderController;
  int get currentPage => _currentPage.value;

  // Setters
  set selectedPosition(value) => _selectedPosition.value = value;
  set currentPage(value) => _currentPage.value = value;

  // Update Faviorte cards
  void interestSelection(bool isSelected, int index) {
    // selectedInterestFavorite.updateAll((key, value) => false);
    if (selectedInterestFavorite[index] == true) {
      return;
    }
    selectedInterestFavorite.updateAll((key, value) => false);
    selectedInterestFavorite[index] = !isSelected;
    selectedCategory(chipCategories[index]);
    scrappingInit();
    update();
  }

  // List<dynamic> initHeadlineScrapping(FileInfo output) {
  //   output.file.readAsString().then((value) {
  //     headline.value = (_scrapper.headline(value));
  //     update();
  //   });

  //   return headline;
  // }

  @override
  void onInit() {
    scrappingInit();
    user = (authcontroller.state as Authenticated).user.obs;
    super.onInit();
  }

  ///Method to query all the information I need for news scrapping
  void scrappingInit() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      isLoading.value = false;
      try {
        fileStream = DefaultCacheManager()
            .getFileStream(
              getUrl(),
            )
            .asBroadcastStream();
        fileStream!.listen(
          (event) {
            var data = event as FileInfo;
            data.file.readAsString().then((value) {
              headline = _scrapper.headline(value);
              headlineList = headline.take(3).toList();
              newsList = headline.skip(3).take(10).toList();
              update();
            });
          },
        );
      } catch (e) {
        isLoading.value = false;
        logError(e.toString());
      }
    });
  }

  String getUrl() {
    switch (selectedCategory.value) {
      case 'Random':
        return 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/browse.archive.php?more';
      case 'Sports':
        return 'https://www.ghanaweb.com/GhanaHomePage/SportsArchive/browse.archive.php?more';
      case 'Business':
        return 'https://www.ghanaweb.com/GhanaHomePage/business/browse.archive.php?more';
      case 'Entertainment':
        return 'https://www.ghanaweb.com/GhanaHomePage/entertainment/browse.archive.php?more';
      case 'Africa':
        return 'https://www.ghanaweb.com/GhanaHomePage/africa/browse.archive.php?more';
      default:
        return 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/browse.archive.php?more';
    }
  }
}
