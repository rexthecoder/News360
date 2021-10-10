
import 'package:news360/resources/assets/assets.gen.dart';

class HomeParallaxCardItem {
  HomeParallaxCardItem({
    required this.title,
    required this.body,
    required this.imagePath,
  });
  final String title;
  final String body;
  final String imagePath;
}

final homeParallaxCardItemsList = <HomeParallaxCardItem>[
  HomeParallaxCardItem(
    title: 'POLITICS',
    body: 'The latest situation in the presidential election',
    imagePath: Assets.images.onboarding1.path,
  ),
  HomeParallaxCardItem(
    title: 'Free Spirit',
    body: 'Khalid',
    imagePath: Assets.images.onboarding2.path,
  ),
  HomeParallaxCardItem(
    title: 'Overexposed',
    body: 'Maroon 5',
    imagePath: Assets.images.onboarding3.path,
  ),
];
