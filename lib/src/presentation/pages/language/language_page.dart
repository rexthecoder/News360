/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
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
import 'package:spaces/spaces.dart';

import '../../../logic/global/lanaguages_list.dart';
import '../../templates/export.dart';
import '../../theme/theme.dart';
import 'controller/lanaguage_controller.dart';

class LanguagePage extends GetView<LanguageController> {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: _LanguagePageBody(
        controller: controller,
      ),
    );
  }
}

class _LanguagePageBody extends StatelessWidget {
  const _LanguagePageBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LanguageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(EvaIcons.arrowBack),
            ),
            AutoSizeText(
              'Language',
              style: context.h5.copyWith(
                color: AppColors.blackPrimary,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
          ],
        ),
        const Space.normal(),
        _LanguageBuilderCard(
          controller: controller,
        )
      ],
    );
  }
}

class _LanguageBuilderCard extends StatelessWidget {
  const _LanguageBuilderCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LanguageController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (_) {
        return SizedBox(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              controller.trackSelected(index: index);
              return GestureDetector(
                onTap: () => controller.updateLanguageSelected(index: index),
                child: LanguageAniamtionCard(
                  label: lanaguages[index],
                  state: controller.isSelected,
                ),
              );
            },
            itemCount: lanaguages.length,
          ),
        );
      },
    );
  }
}

class LanguageAniamtionCard extends StatelessWidget {
  const LanguageAniamtionCard({
    Key? key,
    required this.state,
    required this.label,
  }) : super(key: key);

  final bool? state;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossClip(
      firstChild: LanguageCard(
        label: label,
        state: state!,
      ),
      secondChild: LanguageCard(
        backgroundColor: AppColors.purplePrimary,
        color: AppColors.white,
        label: label,
        state: state!,
      ),
      crossClipState:
          state! ? CrossClipState.showSecond : CrossClipState.showFirst,
      duration: const Duration(milliseconds: 300),
      pathBuilder: PathBuilders.splitHorizontalIn,
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
    );
  }
}

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    Key? key,
    required this.label,
    required this.state,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  final String label;
  final bool state;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      margin:
          context.spacing().insets.horizontal.semiSmall.copyWith(bottom: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.greyLighter,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: AutoSizeText(
          label,
          style: context.h6.copyWith(
            color: color ?? AppColors.blackPrimary,
          ),
        ),
        trailing: state
            ? Icon(
                EvaIcons.checkmark,
                color: color ?? AppColors.blackPrimary,
              )
            : null,
      ),
    );
  }
}
