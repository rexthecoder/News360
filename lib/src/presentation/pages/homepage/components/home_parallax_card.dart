import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:news360/src/presentation/pages/onboarding/components/card_transformer.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

import 'homecardlist.dart';

class ParallaxCards extends StatelessWidget {
  const ParallaxCards({
    Key? key,

    required this.pageVisibility,
    this.imageUrl,
    this.discription,
  }) : super(key: key);

  // final HomeParallaxCardItem item;
  final PageVisibility pageVisibility;
  final String? imageUrl;
  final String? discription;

  Widget _applyTextEffects({
    required double translationFactor,
    required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
        opacity: pageVisibility.visibleFraction,
        child: Transform(
          alignment: FractionalOffset.topLeft,
          transform: Matrix4.translationValues(
            xTranslation,
            0.0,
            0.0,
          ),
          child: child,
        ));
  }

  _buildTextContainer(BuildContext context) {
    var categoryText = _applyTextEffects(
        translationFactor: 300.0,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AutoSizeText(
              'Headline',
              style: context.bodyText2.copyWith(
                color: AppColors.greyLighter,
              ),
            )));

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AutoSizeText(
          discription!,
          style: context.bodyText1.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );

    return Positioned(
        bottom: 30.0,
        left: 10.0,
        right: 10.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categoryText,
              titleText,
            ]));
  }

  @override
  Widget build(BuildContext context) {
    var image = Image(
        image: OptimizedCacheImageProvider(imageUrl!),
        fit: BoxFit.cover,
        alignment: FractionalOffset(
          0.5 + (pageVisibility.pagePosition / 3),
          0.5,
        ));

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, AppColors.blackLightter],
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        child: SizedBox(
          height: 600,
          width: double.infinity,
          child: Stack(fit: StackFit.expand, children: [
            image,
            imageOverlayGradient,
            _buildTextContainer(context),
          ]),
        ),
      ),
    );
  }
}
