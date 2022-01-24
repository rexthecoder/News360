/*
 * Copyright (c) 2021, Rexford Asamoah Agyapong
 * Use of this source code is governed by an MIT-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:animated_clipper/animated_clipper.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:spaces/spaces.dart';

import '../../../logic/global/categories.dart';
import '../../../logic/global/variables.dart';
import '../../templates/export.dart';
import '../../theme/app_colors.dart';
import '../../theme/theme.dart';
import 'controller/home_controller.dart';
import 'sub/bookmark_section.dart';
import 'sub/categories_section.dart';
import 'sub/main_section.dart';
import 'sub/profile_section.dart';

/// Steteless Presentation view with nav bar attach to it.
class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _LoadingPointerAbsorber(
      child: AppWrapper(
        bottomNavigationBar: _CustomNavigationBar(),
        child: _CustomTransitionSection(),
      ),
    );
  }
}

class _LoadingPointerAbsorber extends StatelessWidget {
  const _LoadingPointerAbsorber({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: isPointerAbsorbing.value,
        child: child,
      ),
    );
  }
}

class _CustomTransitionSection extends GetView<HomeController> {
  const _CustomTransitionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FadeIndexedStack(
        index: controller.selectedPosition.value,
        children: const [
          MainPage(),
          CategoriesPage(),
          BookmarkPage(),
          ProfilePage()
        ],
      ),
    );
  }
}

class ArticleCards extends GetView<HomeController> {
  const ArticleCards({
    Key? key,
    required this.index,
    this.image,
    required this.url,
    required this.title,
  }) : super(key: key);

  final int index;
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
              tag: 'product$index',
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
                  controller.selectedCategory.value,
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

class ChipListView extends GetView<HomeController> {
  const ChipListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (_) {
        return Padding(
          padding: context.spacing().insets.horizontal.semiSmall,
          child: SizedBox(
            height: 50,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              addRepaintBoundaries: true,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: chipCategories
                  .asMap()
                  .map(
                    (index, item) {
                      controller.selectedInterestFavorite[index] =
                          controller.selectedInterestFavorite[index] ?? false;
                      bool? isSelected =
                          controller.selectedInterestFavorite[index];
                      return MapEntry(
                        index,
                        GestureDetector(
                          onTap: () => _.interestSelection(isSelected!, index),
                          child: ChipAniamtionCard(
                            index: index,
                            state: isSelected,
                          ),
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class ChipAniamtionCard extends StatelessWidget {
  const ChipAniamtionCard({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  final bool? state;

  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossClip(
      firstChild: CustomChip(
        index: index,
        color: AppColors.greyLighter,
      ),
      secondChild: CustomChip(
        textColor: AppColors.white,
        index: index,
        color: AppColors.purplePrimary,
      ),
      crossClipState:
          state! ? CrossClipState.showSecond : CrossClipState.showFirst,
      duration: const Duration(milliseconds: 300),
      pathBuilder: PathBuilders.slideUp,
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.index,
    required this.color,
    this.textColor,
  }) : super(key: key);
  final int index;
  final Color color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 15),
      child: Transform.scale(
        scale: 1.2,
        child: Chip(
          backgroundColor: color,
          label: Text(
            chipCategories[index],
            style: context.bodyText2.copyWith(
              color: textColor ?? AppColors.greyPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomNavigationBar extends GetView<HomeController> {
  const _CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FancyBottomBar(
        selectedPosition: controller.selectedPosition.value,
        selectedColor: AppColors.purplePrimary,
        indicatorColor: AppColors.purplePrimary,

        items: [
          bottomNavigationList(
            context: context,
            label: 'Home',
            icon: EvaIcons.homeOutline,
          ),
          bottomNavigationList(
            context: context,
            label: 'Categories',
            icon: EvaIcons.gridOutline,
          ),
          bottomNavigationList(
            context: context,
            label: 'Bookmarks',
            icon: EvaIcons.bookmarkOutline,
          ),
          bottomNavigationList(
            context: context,
            label: 'Profile',
            icon: EvaIcons.personOutline,
          ),
        ],
        onItemSelected: (i) => controller.selectedPosition(i),
        // selectedPosition: selectedPos,
      ),
    );
  }

  FancyBottomItem bottomNavigationList(
      {required BuildContext context, String? label, IconData? icon}) {
    return FancyBottomItem(
      title: AutoSizeText(
        label!,
        style: context.bodyText1.copyWith(
          color: isDarkMode ? AppColors.white : AppColors.blackPrimary,
        ),
      ),
      icon: Icon(
        icon,
        size: 22,
        color: AppColors.greyPrimary,
      ),
    );
  }
}
