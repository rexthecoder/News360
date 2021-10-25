import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/global/variables.dart';
import 'package:news360/src/presentation/templates/export.dart';

import 'package:news360/src/presentation/theme/theme.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:spaces/spaces.dart';

import 'controller/category_more_controller.dart';

class CategoryMorePage extends GetView<CategoryMoreController> {
  const CategoryMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _CategoryMoreBody(controller: controller),
      ),
    );
  }
}

class _CategoryMoreBody extends StatelessWidget {
  const _CategoryMoreBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CategoryMoreController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CategoryMoreBackButton(),
        const Space.small(),
        _CategoryMoreBuilder(
          controller: controller,
        )
      ],
    );
  }
}

class _CategoryMoreBuilder extends StatelessWidget {
  const _CategoryMoreBuilder({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CategoryMoreController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryMoreController>(
      init: CategoryMoreController(),
      initState: (_) {},
      builder: (_) {
        return Skeleton(
          isLoading: controller.headline.isEmpty,
          skeleton: Padding(
            padding:
                context.spacing().insets.horizontal.normal.copyWith(right: 10),
            child: SizedBox(
              height: 300,
              child: SkeletonListView(
                itemCount: 4,
              ),
            ),
          ),
          child: Column(
            children: controller.headline
                .map(
                  (e) => CategoryCards(
                    index: e['title'],
                    url: e['link'],
                    image: e['image'],
                    title: e['title'],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _CategoryMoreBackButton extends StatelessWidget {
  const _CategoryMoreBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      color: AppColors.greyPrimary,
      icon: const Icon(
        EvaIcons.arrowBackOutline,
      ),
    );
  }
}

class CategoryCards extends GetView<CategoryMoreController> {
  const CategoryCards({
    Key? key,
    required this.index,
    this.image,
    required this.url,
    required this.title,
  }) : super(key: key);

  final dynamic index;
  final String? image;
  final String title;
  final String url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        'article',
        arguments: {'index': index, 'url': url},
      ),
      child: Padding(
        padding: context.spacing().insets.vertical.small,
        child: Row(
          children: [
            Hero(
              tag: "product$index",
              child: Container(
                height: 100,
                width: 100,
                margin: context.spacing().insets.horizontal.normal,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: OptimizedCacheImageProvider(
                      image!,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  controller.selectedMore.value,
                  style: context.bodyText2.copyWith(
                    color: AppColors.greyPrimary,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: AutoSizeText(
                    title,
                    style: context.bodyText1.copyWith(
                      color:
                          isDarkMode ? AppColors.white : AppColors.blackPrimary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
