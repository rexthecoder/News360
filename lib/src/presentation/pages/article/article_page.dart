/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news360/src/logic/global/variables.dart';
import 'package:news360/src/presentation/templates/export.dart';

import 'package:news360/src/presentation/theme/theme.dart';
import 'package:news360/src/resources/assets/assets.gen.dart';
import 'package:skeletons/skeletons.dart';
import 'package:spaces/spaces.dart';
import 'controller/article_controller.dart';

class ArticlePage extends GetView<ArticleController> {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: GetBuilder(
        init: ArticleController(),
        builder: (_) {
          return _ArticleBody(
            controller: controller,
          );
        },
      ),
    );
  }
}

class _ArticleBody extends StatelessWidget {
  const _ArticleBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ArticleController controller;

  @override
  Widget build(BuildContext context) {
    return FadingEdgeScrollView.fromSingleChildScrollView(
      shouldDisposeScrollController: true,
      gradientFractionOnStart: 0.3,
      gradientFractionOnEnd: 0.3,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollcontroller,
        child: Skeleton(
          skeleton: const _SkeletonWidget(),
          isLoading: controller.contents.isEmpty ? true : false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const _ArticleHeader(),
              _ArticleImage(
                controller: controller,
              ),
              const Space.normal(),
              _ArticleChips(
                controller: controller,
              ),
              const Space.small(),
              _ArticleTitle(
                controller: controller,
              ),
              const Space.small(),
              _ArticleContent(
                controller: controller,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  const _ArticleContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ArticleController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.5,
      Padding(
        padding: context.spacing().insets.horizontal.semiSmall,
        child: AutoSizeText(
          controller.contents['content'] ?? '',
          style: context.bodyText1.copyWith(
            color: AppColors.greyPrimary,
          ),
        ),
      ),
    );
  }
}

class _ArticleTitle extends StatelessWidget {
  const _ArticleTitle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ArticleController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.3,
      Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 15),
        child: AutoSizeText(
          controller.contents['title'] ?? '',
          style: context.h6.copyWith(
            color: AppColors.blackPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ArticleChips extends StatelessWidget {
  const _ArticleChips({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ArticleController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.3,
      Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 15),
        child: Transform.scale(
          scale: 1.2,
          child: Chip(
            backgroundColor: AppColors.purplePrimary,
            label: AutoSizeText(
              controller.contents['type'].toString().split(" ").first,
              style: context.bodyText2.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  const _ArticleImage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ArticleController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.8,
      Padding(
        padding: context.spacing().insets.horizontal.normal,
        child: Hero(
          tag: 'product${controller.index}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Obx(
              () => SizedBox(
                height: controller.scrollOffset.value > 200
                    ? 0
                    : 200 - (controller.scrollOffset.value),
                width: double.infinity,
                child: Image.network(
                  controller.contents['image'],
                  fit: BoxFit.fill,
                  alignment: AlignmentDirectional.topStart,
                  colorBlendMode: BlendMode.srcATop,
                  color: const Color(0xff22242F).withAlpha(80),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleHeader extends StatelessWidget {
  const _ArticleHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.5,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Get.back(),
            color: AppColors.greyPrimary,
            icon: const Icon(
              EvaIcons.arrowBackOutline,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                color: AppColors.greyPrimary,
                icon: const Icon(EvaIcons.undoOutline),
              ),
              IconButton(
                onPressed: () {},
                color: AppColors.greyPrimary,
                icon: const Icon(EvaIcons.bookmarkOutline),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonWidget extends StatelessWidget {
  const _SkeletonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          Assets.images.book.path,
          color: isDarkMode ? AppColors.white : AppColors.purplePrimary,
        ),
      ),
    );
  }
}
