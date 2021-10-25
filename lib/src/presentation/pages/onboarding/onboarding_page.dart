/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news360/src/presentation/pages/onboarding/components/button_effect.dart';
import 'package:news360/src/presentation/pages/onboarding/controller/onboarding_controller.dart';
import 'package:news360/src/presentation/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spaces/spaces.dart';
import 'package:awesome_flutter_extensions/all.dart';

import 'components/card_transformer.dart';
import 'components/carousel.dart';
import 'components/effect.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  OnBoardingPage({Key? key}) : super(key: key);

  final OnBoardingController c = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: _OnBoardingPage(
        controller: controller,
      ),
    );
  }
}

class _OnBoardingPage extends StatelessWidget {
  const _OnBoardingPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // const Space.big(),
          _OnBoardingPageCard(controller: controller),
          const Space.normal(),
          SmoothPageIndicator(
            controller: controller.sliderController, // PageController
            count: parallaxCardItemsList.length,

            effect: WormEffect(
              activeDotColor: AppColors.purplePrimary,
              dotHeight: 10,
              dotWidth: 10,
            ), // your preferred effect
            onDotClicked: (index) {},
          ),
          const Space.normal(),
          AutoSizeText(
            'First to Know',
            style: context.h6
                .copyWith(color: AppColors.blackPrimary, letterSpacing: 1.5),
          ),
          const Space.normal(),

          AutoSizeText(
            'All news in one place, be the\nfirst to know last news',
            textAlign: TextAlign.center,
            style: context.bodyText2
                .copyWith(color: AppColors.greyPrimary, letterSpacing: 1.5),
          ),
          const Space.normal(),
          const Spacer(),
          const ButtonEffect(),

          const Space.normal(),
        ],
      ),
    );
  }
}

class _OnBoardingPageCard extends StatelessWidget {
  const _OnBoardingPageCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SizedBox.fromSize(
        size: const Size.fromHeight(450.0),
        child: PageTransformer(
          pageViewBuilder: (context, visibilityResolver) {
            return PageView.builder(
              controller: controller.sliderController,
              itemCount: parallaxCardItemsList.length,
              itemBuilder: (context, index) {
                final item = parallaxCardItemsList[index];
                final pageVisibility =
                    visibilityResolver.resolvePageVisibility(index);
                return ParallaxCards(
                  item: item,
                  pageVisibility: pageVisibility,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
