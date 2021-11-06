import '../../../../resources/assets/assets.gen.dart';

class ParallaxCardItem {
  ParallaxCardItem({
    required this.title,
    required this.body,
    required this.imagePath,
  });
  final String title;
  final String body;
  final String imagePath;
}

final parallaxCardItemsList = <ParallaxCardItem>[
  ParallaxCardItem(
    title: 'Blurryface',
    body: 'Twenty One Pilots',
    imagePath: Assets.images.onboarding1.path,
  ),
  ParallaxCardItem(
    title: 'Free Spirit',
    body: 'Khalid',
    imagePath: Assets.images.onboarding2.path,
  ),
  ParallaxCardItem(
    title: 'Overexposed',
    body: 'Maroon 5',
    imagePath: Assets.images.onboarding3.path,
  ),
];
