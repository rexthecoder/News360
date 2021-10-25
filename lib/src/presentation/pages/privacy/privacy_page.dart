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
import 'package:news360/src/logic/global/policies.dart';
import 'package:news360/src/presentation/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

class PrivacyPage extends GetView {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return AppWrapper(
        child: _PrivacyBody(
      controller: controller,
    ));
  }
}

class _PrivacyBody extends StatelessWidget {
  const _PrivacyBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return FadingEdgeScrollView.fromSingleChildScrollView(
      shouldDisposeScrollController: true,
      gradientFractionOnStart: 0.6,
      gradientFractionOnEnd: 0.6,
      child: SingleChildScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(EvaIcons.arrowBack),
                ),
                AutoSizeText(
                  'Privacy Policies',
                  style: context.h5.copyWith(
                    color: AppColors.blackPrimary,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
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
    );
  }
}
