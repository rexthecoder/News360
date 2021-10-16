import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/scrapper/apps_scrapper.dart';

class ArticleController extends GetxController {
  final scrollcontroller = ScrollController();
  final _scraping = Scrapper();
  late final int index;
  RxMap contents = {}.obs;
  final scrollOffset = 0.0.obs;

  @override
  void onInit() {
    scrappingInit();
    super.onInit();
  }

  Future<void> scrappingInit() async {
    index = Get.arguments['index'];
    var url = Get.arguments['url'];
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      scrollcontroller.addListener(() {
        scrollOffset(scrollcontroller.position.pixels);
      });
      var response = await _scraping.init(
        link: 'https://www.ghanaweb.com/$url',
      );
      contents = _scraping.content(response.body).obs;
      update();
    });
  }
}
