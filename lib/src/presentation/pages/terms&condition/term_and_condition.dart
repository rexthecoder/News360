import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

import '../../../logic/global/policies.dart';
import '../../templates/export.dart';
import '../../theme/theme.dart';

class TermsAndConditionPage extends GetView {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return AppWrapper(
      child: _TermsBody(
        controller: controller,
      ),
    );
  }
}

class _TermsBody extends StatelessWidget {
  const _TermsBody({
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
                  'Terms & Conditions',
                  style: context.h5.copyWith(
                    color: AppColors.blackPrimary,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            ),
            const Space.small(),
            Padding(
              padding: context.spacing().insets.horizontal.semiSmall,
              child: AutoSizeText(
                terms,
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
