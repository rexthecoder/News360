import 'package:flutter/material.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'carousel.dart';
import 'card_transformer.dart';

class ParallaxCards extends StatelessWidget {
  const ParallaxCards({
    Key? key,
    required this.item,
    required this.pageVisibility,
  }) : super(key: key);

  final ParallaxCardItem item;
  final PageVisibility pageVisibility;

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(item.imagePath,
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 22.0,
        horizontal: 8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          child: SizedBox(
            height: 600,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                image,
                imageOverlayGradient,
                // _buildTextContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
