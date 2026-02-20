import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../core/assets/assets.gen.dart';
import '../core/themes/app_colors.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double? height, width;
  final BorderRadius? borderRadius;
  final bool showLoader;
  final Color? backgroundColor;

  const ImageWidget({
    super.key,
    required this.image,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadius,
    this.showLoader = true,
    this.backgroundColor,
  });

  bool get _isSvg => image.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    // 🟢 حالة: الصورة فاضية
    if (image.isEmpty) return _fallbackImage();

    // 🟣 حالة: SVG
    if (_isSvg) {
      return _buildSvgImage();
    }

    // 🟢 حالة: صورة عادية
    return _buildCachedImage();
  }

  // 🖼️ CachedNetworkImage مع Loader وسكلتون
  Widget _buildCachedImage() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: fit,
        height: height?.h,
        width: width?.w,
        placeholder: (context, url) => _loaderPlaceholder(),
        errorWidget: (context, url, error) => _fallbackImage(),
      ),
    );
  }

  // 🟣 SVG صورة
  Widget _buildSvgImage() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SvgPicture.network(
        image,
        fit: fit,
        height: height?.h,
        width: width?.w,
        placeholderBuilder: (context) => _loaderPlaceholder(),
      ),
    );
  }

  // 💡 Loader + Skeleton أثناء التحميل
  Widget _loaderPlaceholder() {
    return Skeletonizer(
      enabled: true,
      child: Container(
        height: height?.h,
        width: width?.w,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade200,
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: showLoader
            ? Center(
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.primary,
            ),
          ),
        )
            : const SizedBox.shrink(),
      ),
    );
  }

  // ❌ fallback في حال فشل التحميل أو الرابط فاضي
  Widget _fallbackImage() {
    return ClipRRect(
      borderRadius: borderRadius?.r ?? BorderRadius.zero,
      child: Assets.banner.banner.image(
        fit: fit,
        height: height?.h,
        width: width?.w,
      ),
    );
  }
}
