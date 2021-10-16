/*
 * Copyright (c) 2021, Rexford Asamoah Agyapong
 * Use of this source code is governed by an MIT-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:flutter/material.dart';
import 'package:animated_clipper/animated_clipper.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/global/categories.dart';
import 'package:news360/src/logic/global/variables.dart';
import 'package:news360/src/presentation/pages/global/templates/bottom_navigation/fancy_bottom_bar.dart';

import 'package:news360/src/presentation/pages/global/templates/fade/fade_index_stack.dart';
import 'package:news360/src/presentation/pages/global/templates/widget_wrapper.dart';
import 'package:news360/src/presentation/pages/onboarding/components/card_transformer.dart';
import 'package:news360/src/presentation/theme/app_colors.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spaces/spaces.dart';

import 'components/home_parallax_card.dart';
import 'components/search_bar.dart';
import 'controller/home_controller.dart';
import 'sub/bookmark_section.dart';
import 'sub/categories_section.dart';
import 'sub/profile_section.dart';

/// Presentation with nav bar attach to it.
class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppWrapper(
      bottomNavigationBar: _CustomNavigationBar(),
      child: _CustomTransitionSection(),
    );
  }
}

class _CustomTransitionSection extends GetView<HomeController> {
  const _CustomTransitionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => FadeIndexedStack(
          index: controller.selectedPosition.value,
          children: const [
            MainPage(),
            CategoriesPage(),
            BookmarkPage(),
            ProfilePage()
          ],
        ));
    // return Obx(() => BottomBarPageTransition(
    //       currentIndex: controller.selectedPosition.value,
    //       totalLength: controller.totalPage,
    //       transitionType: controller.transitionType,
    //       transitionDuration: const Duration(milliseconds: 495),
    //       builder: (_, index) => IndexedStack(
    //         index: index,
    //         children: const [
    //           MainPage(),
    //           CategoriesPage(),
    //           BookmarkPage(),
    //           ProfilePage()
    //         ],
    //       ),
    //     ));
  }
}

class MainPage extends GetView<HomeController> {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            // width: double.infinity,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Space.normal(),
                    Padding(
                      padding: context.spacing().insets.horizontal.normal,
                      child: AutoSizeText(
                        'Browse',
                        style: context.h5.copyWith(
                          color: AppColors.blackPrimary,
                        ),
                      ),
                    ),
                    const Space.semiSmall(),
                    Padding(
                      padding: context.spacing().insets.horizontal.normal,
                      child: AutoSizeText(
                        'Discover things of this world',
                        style: context.bodyText1.copyWith(
                          color: AppColors.greyPrimary,
                        ),
                      ),
                    ),
                    const Space.extraBig(),
                    //  Expanded(child: Container(child: const CustomSearchBar())),
                    const ChipListView(),
                    const Space.normal(),
                    SizedBox.fromSize(
                      size: const Size.fromHeight(300.0),
                      child: GetBuilder<HomeController>(
                        init: HomeController(),
                        initState: (_) {},
                        builder: (_) {
                          return Skeleton(
                            isLoading: isLoading.value,
                            skeleton: Padding(
                              padding: context
                                  .spacing()
                                  .insets
                                  .horizontal
                                  .normal
                                  .copyWith(right: 10),
                              child: SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: double.infinity,
                                  minHeight:
                                      MediaQuery.of(context).size.height / 8,
                                  maxHeight: MediaQuery.of(context).size.height,
                                ),
                              ),
                            ),
                            child: PageTransformer(
                              pageViewBuilder: (context, visibilityResolver) {
                                return PageView.builder(
                                  pageSnapping: true,
                                  padEnds: false,
                                  physics: const BouncingScrollPhysics(),
                                  controller: controller.sliderController,
                                  itemCount: controller.headlineList.length,
                                  itemBuilder: (context, index) {
                                    final pageVisibility = visibilityResolver
                                        .resolvePageVisibility(index);
                                    return GestureDetector(
                                      onTap: () => Get.toNamed(
                                        'article',
                                        arguments: {
                                          'index': index,
                                          'url': controller.headlineList[index]
                                              ['link']
                                        },
                                      ),
                                      child: Padding(
                                        padding: context
                                            .spacing()
                                            .insets
                                            .horizontal
                                            .normal
                                            .copyWith(right: 10),
                                        child: ParallaxCards(
                                          discription: controller
                                              .headlineList[index]['title'],
                                          pageVisibility: pageVisibility,
                                          imageUrl: controller
                                              .headlineList[index]['image'],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const Space.small(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: context.spacing().insets.horizontal.normal,
                        child: SmoothPageIndicator(
                          controller:
                              controller.sliderController, // PageController
                          count: 3,
                          effect: WormEffect(
                            activeDotColor: AppColors.purplePrimary,
                            dotHeight: 8,
                            dotWidth: 10,
                          ), // your preferred effect
                          onDotClicked: (index) {},
                        ),
                      ),
                    ),
                    const Space.semiBig(),
                    Padding(
                      padding: context.spacing().insets.horizontal.normal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'Recommended for you',
                            style: context.bodyText1.copyWith(
                              color: AppColors.blackPrimary,
                            ),
                          ),
                          const Space.semiSmall(),
                          InkWell(
                            onTap: () => Get.toNamed('more'),
                            child: AutoSizeText(
                              'See All',
                              style: context.bodyText2.copyWith(
                                color: AppColors.greyPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Space.normal(),
                    GetBuilder<HomeController>(
                      init: HomeController(),
                      initState: (_) {},
                      builder: (_) {
                        return Skeleton(
                          isLoading: isLoading.value,
                          skeleton: SizedBox(
                              height: 300,
                              child: SkeletonListView(
                                itemCount: 4,
                              )),
                          child: SizedBox(
                            child: ListView.builder(
                              itemCount: controller.newsList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ArticleCards(
                                index: index,
                                url: controller.newsList[index]['link'],
                                image: controller.newsList[index]['image'],
                                title: controller.newsList[index]['title'],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                    height: controller.screenHieght,
                    child: const CustomSearchBar()),
              ],
            ),
          ),
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
                      color: AppColors.blackPrimary,
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
          color: AppColors.blackPrimary,
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
