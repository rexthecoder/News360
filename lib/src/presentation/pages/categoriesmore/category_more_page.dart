import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/global/variables.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
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
            GetBuilder<CategoryMoreController>(
              init: CategoryMoreController(),
              initState: (_) {},
              builder: (_) {
                return Skeleton(
                    isLoading: controller.headline.isEmpty,
                    skeleton: Padding(
                      padding: context
                          .spacing()
                          .insets
                          .horizontal
                          .normal
                          .copyWith(right: 10),
                      child: SizedBox(
                          height: 300,
                          child: SkeletonListView(
                            itemCount: 4,
                          )),
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
                    ));
              },
            )
          ],
        ),
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
