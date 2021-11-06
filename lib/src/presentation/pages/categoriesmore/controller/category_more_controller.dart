import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../../../logic/scrapper/apps_scrapper.dart';

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
              if (headline.length > 20) {
                headline = headline.take(15).toList();
              }
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
      case 'News':
        return 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/browse.archive.php?more';
      case 'Sports':
        return 'https://www.ghanaweb.com/GhanaHomePage/SportsArchive/browse.archive.php?more';
      case 'Business':
        return 'https://www.ghanaweb.com/GhanaHomePage/business/browse.archive.php?more';
      case 'Entertainment':
        return 'https://www.ghanaweb.com/GhanaHomePage/entertainment/browse.archive.php?more';
      case 'Africa':
        return 'https://www.ghanaweb.com/GhanaHomePage/africa/browse.archive.php?more';
      case 'Crime':
        return 'https://www.ghanaweb.com/GhanaHomePage/crime/browse.archive.php?more';
      case 'Politics':
        return 'https://www.ghanaweb.com/GhanaHomePage/politics/browse.archive.php?more';
      case 'Regional':
        return 'https://www.ghanaweb.com/GhanaHomePage/regional/browse.archive.php?more';
      case 'Health':
        return 'https://www.ghanaweb.com/GhanaHomePage/health/browse.archive.php?more';
      case 'World':
        return 'https://www.ghanaweb.com/GhanaHomePage/world/browse.archive.php?more';
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
