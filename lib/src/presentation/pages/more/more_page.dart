import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/presentation/pages/global/templates/widget_wrapper.dart';
import 'package:news360/src/presentation/pages/homepage/controller/home_controller.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

import '../pages.dart';

class MorePage extends GetView<HomeController> {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              color: AppColors.greyPrimary,
              icon: const Icon(
                EvaIcons.arrowBackOutline,
              ),
            ),
            const Space.small(),
            GetBuilder<HomeController>(
              init: HomeController(),
              initState: (_) {},
              builder: (_) {
                return SizedBox(
                  child: ListView.builder(
                    itemCount: controller.headline.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ArticleCards(
                      index: index,
                      url: controller.headline[index]['link'],
                      image: controller.headline[index]['image'],
                      title: controller.headline[index]['title'],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
