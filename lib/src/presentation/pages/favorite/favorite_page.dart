import 'package:animated_clipper/animated_clipper.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/global/categories.dart';
import 'package:news360/src/presentation/pages/global/templates/blue_expanded_button.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
import 'package:news360/src/presentation/theme/app_colors.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

import 'controller/favorite_controller.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteController _ = Get.put(FavoriteController());
    return AppWrapper(
      child: ProgressHUD(
        child: Builder(builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: context.spacing().insets.horizontal.normal,
              child: GetBuilder<FavoriteController>(builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Space.normal(),
                    AutoSizeText(
                      'Select your favorite topics',
                      style: context.h5.copyWith(
                        color: AppColors.blackPrimary,
                      ),
                    ),
                    const Space.semiSmall(),
                    AutoSizeText(
                      'Select some of your favorite topics to let us suggest better news for you.',
                      style: context.bodyText1.copyWith(
                        color: AppColors.greyPrimary,
                      ),
                    ),
                    const Space.semiBig(),
                    SizedBox(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          controller.selectedInterestFavorite[index] =
                              controller.selectedInterestFavorite[index] ??
                                  false;
                          bool? isSelected =
                              controller.selectedInterestFavorite[index];
                          return GestureDetector(
                            onTap: () =>
                                _.interestSelection(isSelected!, index),
                            child: FavoriteAniamtionCard(
                              label: categories[index],
                              state: isSelected,
                            ),
                          );
                        },
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 1.8,
                        ),
                      ),
                    ),
                    const Space.normal(),
                    BlueExpandedButton(
                      label: 'Complete',
                      onPressed: () => controller.addToDataBase(context),
                    ),
                    const Space.normal(),
                  ],
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

class FavoriteAniamtionCard extends StatelessWidget {
  const FavoriteAniamtionCard({
    Key? key,
    required this.state,
    required this.label,
  }) : super(key: key);

  final bool? state;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossClip(
      firstChild: FavoriteCard(
        color: AppColors.greyLighter,
        label: label,
      ),
      secondChild: FavoriteCard(
        textColor: AppColors.white,
        color: AppColors.purplePrimary,
        label: label,
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

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    Key? key,
    required this.color,
    required this.label,
    this.textColor,
  }) : super(key: key);

  final Color color;
  final String label;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 78,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: AutoSizeText(
            label,
            style: context.bodyText1.copyWith(
              color: textColor ?? AppColors.greyPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
