import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/scrapper/apps_scrapper.dart';

class ArticleController extends GetxController {
  final scrollcontroller = ScrollController();
  final _scraping = Scrapper();
  late final int index;
  List contents = [];
  final scrollOffset = 0.0.obs;

  @override
  void onInit() {
    index = Get.arguments['index'];
    var url = Get.arguments['url'];
    print(url);
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      scrollcontroller.addListener(() {
        scrollOffset(scrollcontroller.position.pixels);
      });
      // var response = await _scraping.init(
      //     link: 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/$url');
      // contents = _scraping.content(response.body);

      // print(contents);
    });
    super.onInit();
  }
}
