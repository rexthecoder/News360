/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

import '../../templates/export.dart';
import '../../theme/theme.dart';
import '../pages.dart';

class MorePage extends GetView<HomeController> {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: _MorePageBody(
        controller: controller,
      ),
    );
  }
}

class _MorePageBody extends StatelessWidget {
  const _MorePageBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          _MorePageCard(
            controller: controller,
          )
        ],
      ),
    );
  }
}

class _MorePageCard extends StatelessWidget {
  const _MorePageCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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
    );
  }
}
