import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/resources/assets/assets.gen.dart';
import 'package:news360/src/logic/global/policies.dart';
import 'package:news360/src/presentation/pages/global/templates/fade/fade_scroll_view.dart';
import 'package:news360/src/presentation/pages/global/templates/widget_wrapper.dart';

import 'package:news360/src/presentation/theme/app_colors.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';
import 'controller/article_controller.dart';

class ArticlePage extends GetView<ArticleController> {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
        child: FadingEdgeScrollView.fromSingleChildScrollView(
      shouldDisposeScrollController: true,
      gradientFractionOnStart: 0.6,
      gradientFractionOnEnd: 0.6,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollcontroller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
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
            Padding(
              padding: context.spacing().insets.horizontal.normal,
              child: Hero(
                tag: 'product${controller.index}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Obx(() => SizedBox(
                        height:controller.scrollOffset.value > 200 ? 0 : 200 - (controller.scrollOffset.value),
                        width: double.infinity,
                        child: Image.asset(
                          Assets.images.onboarding1.path,
                          fit: BoxFit.none,
                          alignment: AlignmentDirectional.topStart,
                          colorBlendMode: BlendMode.srcATop,
                          color: const Color(0xff22242F).withAlpha(80),
                        ),
                      )),
                ),
              ),
            ),
            const Space.normal(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 15),
              child: Transform.scale(
                scale: 1.2,
                child: Chip(
                  backgroundColor: AppColors.purplePrimary,
                  label: AutoSizeText(
                    'Election',
                    style: context.bodyText2.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Space.small(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 15),
              child: AutoSizeText(
                'The latest situation in the presidential election',
                style: context.h6.copyWith(
                  color: AppColors.blackPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: context.spacing().insets.horizontal.semiSmall,
              child: AutoSizeText(
                privacy,
                style: context.bodyText1.copyWith(
                  color: AppColors.greyPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
