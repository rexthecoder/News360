/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/logic.dart';
import 'package:news360/src/presentation/pages/homepage/components/home_parallax_card.dart';
import 'package:news360/src/presentation/pages/homepage/components/search_bar.dart';
import 'package:news360/src/presentation/pages/homepage/controller/home_controller.dart';
import 'package:news360/src/presentation/pages/onboarding/components/card_transformer.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:skeletons/skeletons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spaces/spaces.dart';

import '../home_page.dart';

class MainPage extends GetView<HomeController> {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: _MainPageBody(
        controller: controller,
      ),
    );
  }
}

class _MainPageBody extends StatelessWidget {
  const _MainPageBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          child: Stack(
            fit: StackFit.loose,
            children: [
              _StackHeaderContent(
                controller: controller,
              ),
              SizedBox(
                height: controller.screenHieght,
                child: const CustomSearchBar(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StackHeaderContent extends StatelessWidget {
  const _StackHeaderContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Space.normal(),
        const _MainHeader(),
        const Space.semiSmall(),
        const _HeaderSubText(),
        const Space.extraBig(),
        const ChipListView(),
        const Space.normal(),
        _MainCardCarousal(
          controller: controller,
        ),
        const Space.small(),
        CarousalIndicator(
          controller: controller,
        ),
        const Space.semiBig(),
        const _RecommendedTitle(),
        const Space.normal(),
        _MainListCard(
          controller: controller,
        )
      ],
    );
  }
}

class _HeaderSubText extends StatelessWidget {
  const _HeaderSubText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacing().insets.horizontal.normal,
      child: AutoSizeText(
        'Discover things of this world',
        style: context.bodyText1.copyWith(
          color: AppColors.greyPrimary,
        ),
      ),
    );
  }
}

class _RecommendedTitle extends StatelessWidget {
  const _RecommendedTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacing().insets.horizontal.normal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            'Recommended for you',
            style: context.bodyText1.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.blackPrimary,
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
    );
  }
}

class CarousalIndicator extends StatelessWidget {
  const CarousalIndicator({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: context.spacing().insets.horizontal.normal,
        child: SmoothPageIndicator(
          controller: controller.sliderController, // PageController
          count: 3,
          effect: WormEffect(
            activeDotColor: AppColors.purplePrimary,
            dotHeight: 8,
            dotWidth: 10,
          ), // your preferred effect
          onDotClicked: (index) {},
        ),
      ),
    );
  }
}

class _MainListCard extends StatelessWidget {
  const _MainListCard({
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
        return Skeleton(
          isLoading: controller.newsList.isEmpty,
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
    );
  }
}

class _MainCardCarousal extends StatelessWidget {
  const _MainCardCarousal({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(300.0),
      child: GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (_) {
          return Skeleton(
            isLoading: controller.headlineList.isEmpty,
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
                  minHeight: MediaQuery.of(context).size.height / 8,
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
                    final pageVisibility =
                        visibilityResolver.resolvePageVisibility(index);
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        'article',
                        arguments: {
                          'index': index,
                          'url': controller.headlineList[index]['link']
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
                          discription: controller.headlineList[index]['title'],
                          pageVisibility: pageVisibility,
                          imageUrl: controller.headlineList[index]['image'],
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
    );
  }
}

class _MainHeader extends StatelessWidget {
  const _MainHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacing().insets.horizontal.normal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            'Browse',
            style: context.h5.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.blackPrimary,
            ),
          ),
          isDarkMode
              ? GestureDetector(
                  onTap: () => appdata.write('darkmode', false),
                  child: Text(
                    '🌙',
                    style: context.h6,
                  ),
                )
              : GestureDetector(
                  onTap: () => appdata.write('darkmode', true),
                  child: Text(
                    '🌑',
                    style: context.h6,
                  ),
                )
        ],
      ),
    );
  }
}
