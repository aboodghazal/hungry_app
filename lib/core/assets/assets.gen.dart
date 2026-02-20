// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsBannerGen {
  const $AssetsBannerGen();

  /// File path: assets/banner/Offers.gif
  AssetGenImage get offers => const AssetGenImage('assets/banner/Offers.gif');

  /// File path: assets/banner/banner.gif
  AssetGenImage get banner => const AssetGenImage('assets/banner/banner.gif');

  /// List of all assets
  List<AssetGenImage> get values => [offers, banner];
}

class $AssetsDetailGen {
  const $AssetsDetailGen();

  /// File path: assets/detail/sandwitch_detail.png
  AssetGenImage get sandwitchDetail =>
      const AssetGenImage('assets/detail/sandwitch_detail.png');

  /// File path: assets/detail/shape.svg
  SvgGenImage get shape => const SvgGenImage('assets/detail/shape.svg');

  /// List of all assets
  List<dynamic> get values => [sandwitchDetail, shape];
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/cash.png
  AssetGenImage get cash => const AssetGenImage('assets/icon/cash.png');

  /// File path: assets/icon/error.svg
  SvgGenImage get error => const SvgGenImage('assets/icon/error.svg');

  /// File path: assets/icon/profileVisa.png
  AssetGenImage get profileVisa =>
      const AssetGenImage('assets/icon/profileVisa.png');

  /// File path: assets/icon/shadow.png
  AssetGenImage get shadow => const AssetGenImage('assets/icon/shadow.png');

  /// List of all assets
  List<dynamic> get values => [cash, error, profileVisa, shadow];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/icon_app.png
  AssetGenImage get iconApp => const AssetGenImage('assets/logo/icon_app.png');

  /// File path: assets/logo/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/logo/logo.svg');

  /// List of all assets
  List<dynamic> get values => [iconApp, logo];
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/logo_12.png
  AssetGenImage get logo12 => const AssetGenImage('assets/splash/logo_12.png');

  /// File path: assets/splash/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/splash/splash.png');

  /// File path: assets/splash/splash_screen.png
  AssetGenImage get splashScreen =>
      const AssetGenImage('assets/splash/splash_screen.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo12, splash, splashScreen];
}

class $AssetsTestGen {
  const $AssetsTestGen();

  /// File path: assets/test/burger.glb
  String get burger => 'assets/test/burger.glb';

  /// File path: assets/test/kunckles.jpg
  AssetGenImage get kunckles => const AssetGenImage('assets/test/kunckles.jpg');

  /// File path: assets/test/test.png
  AssetGenImage get test => const AssetGenImage('assets/test/test.png');

  /// File path: assets/test/tomato.png
  AssetGenImage get tomato => const AssetGenImage('assets/test/tomato.png');

  /// List of all assets
  List<dynamic> get values => [burger, kunckles, test, tomato];
}

class Assets {
  const Assets._();

  static const $AssetsBannerGen banner = $AssetsBannerGen();
  static const $AssetsDetailGen detail = $AssetsDetailGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
  static const $AssetsTestGen test = $AssetsTestGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
