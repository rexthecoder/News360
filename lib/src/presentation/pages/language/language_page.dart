import 'package:animated_clipper/animated_clipper.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/global/lanaguages_list.dart';
import 'package:news360/src/presentation/pages/global/templates/widget_wrapper.dart';
import 'package:news360/src/presentation/pages/language/controller/lanaguage_controller.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

class LanguagePage extends GetView<LanguageController> {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
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

          GetBuilder<LanguageController>(
            init: LanguageController(),
            builder: (_) {
              return SizedBox(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    controller.trackSelected(index: index);
                    return GestureDetector(
                      onTap: () =>
                          controller.updateLanguageSelected(index: index),
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
          )

          // Padding(
          //   padding: context.spacing().insets.horizontal.semiSmall,
          //   child: const LanguageCard(
          //     label: 'English',
          //   ),
          // )
        ],
      ),
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
