 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/themes/custom_text_style.dart';

import '../core/themes/app_colors.dart';
import '../core/themes/app_radius.dart';
import 'horizontal_sized_box.dart';


class AppBtn extends StatelessWidget {
  const AppBtn({
    super.key,
    required this.title,
    required this.function,
    this.titleStyle,
    this.borderColor,
    this.btnColor,
    this.width,
    this.textColor,
    this.prefix,
    this.borderWidth,
    this.height,
    this.autoWidth = true,
    this.isLoading = false,
    this.borderRadius,
    this.isNotAvailable = false,
    this.needPadding = true,
    this.boldText = true,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color? borderColor, btnColor, textColor;
  final VoidCallback function;
  final double? width, height, borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final bool isLoading;
  final Widget? prefix;
  final bool autoWidth, isNotAvailable, needPadding, boldText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading || isNotAvailable
          ? null
          : () {
              FocusScope.of(context).unfocus();
              function.call();
            },
      child: Container(
        width: (autoWidth ? width : width ?? 255)?.w,
        height: (height ?? 40).h,
        padding: needPadding
            ? EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isNotAvailable
              ? AppColors.greyTextColor
              : btnColor ?? AppColors.primaryButtonColor,
          borderRadius: borderRadius ?? AppRadius.smallRadius,
          border: borderColor == null
              ? null
              : Border.all(color: borderColor!, width: borderWidth ?? 1),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: textColor ?? AppColors.blackColor,
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefix != null) ...[
                      prefix!,
                      if (title.isNotEmpty) const HorizontalSizedBox(11),
                    ],
                    Text(
                      title,
                      style:
                          (titleStyle?.copyWith(
                                    color: AppColors.primaryTextButtonColor,
                                  ) ??
                                  mainTitle)
                              .copyWith(
                                color:
                                    textColor ??
                                    AppColors.primaryTextButtonColor,
                                fontWeight: !boldText && titleStyle == null
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
