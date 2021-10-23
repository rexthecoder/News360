/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.png');
  AssetGenImage get avatargold =>
      const AssetGenImage('assets/images/avatargold.jpg');
  AssetGenImage get book => const AssetGenImage('assets/images/book.gif');
  AssetGenImage get facebookLogo =>
      const AssetGenImage('assets/images/facebook-logo.png');
  AssetGenImage get flutterLogo =>
      const AssetGenImage('assets/images/flutter_logo.png');
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/google-logo.png');
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding1.jpg');
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding2.jpg');
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding3.jpg');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
