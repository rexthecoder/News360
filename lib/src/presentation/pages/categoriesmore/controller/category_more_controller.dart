import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/scrapper/apps_scrapper.dart';

class CategoryMoreController extends GetxController with UiLoggy {
  var headline = [];

  final Scrapper _scrapper = Scrapper();
  Stream<FileResponse>? fileStream;
  RxString selectedMore = 'Random'.obs;

  ///Method to query all the information I need for news scrapping
  void scrappingInit() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      selectedMore.value = await Get.arguments;
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

              update();
            });
          },
        );
      } catch (e) {
        logError(e.toString());
      }
    });
  }

  String getUrl() {
    switch (selectedMore.value) {
      case 'Random':
        return 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/browse.archive.php?more';
      case 'Sports':
        return 'https://www.ghanaweb.com/GhanaHomePage/SportsArchive/browse.archive.php?more';
      case 'Business':
        return 'https://www.ghanaweb.com/GhanaHomePage/business/browse.archive.php?more';
      case 'Entertainment':
        return 'https://www.ghanaweb.com/GhanaHomePage/entertainment/browse.archive.php?more';
      case 'Africat':
        return 'https://www.ghanaweb.com/GhanaHomePage/africa/browse.archive.php?more';
      default:
        return 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/browse.archive.php?more';
    }
  }

  @override
  void onInit() {
    scrappingInit();
    super.onInit();
  }
}
