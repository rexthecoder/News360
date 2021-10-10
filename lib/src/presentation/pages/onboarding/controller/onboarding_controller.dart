import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

class OnBoardingController extends GetxController {
  final _sliderController = PageController(viewportFraction: 0.85);
  final _spacing = Spacing.of(Get.context!);

  PageController get sliderController => _sliderController;
  SpacingData get spacing => _spacing;
}
