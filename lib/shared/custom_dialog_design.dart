import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/themes/context.dart';
import 'package:huungry/core/themes/custom_text_style.dart';
import 'package:huungry/shared/vertical_sized_box.dart';

import '../core/themes/app_colors.dart';
import '../core/themes/dimintions.dart';
import 'app_btn.dart';


class CustomDialogDesign extends StatefulWidget {
  const CustomDialogDesign({
    super.key,
    required this.yesFunction,
    required this.label,
    this.desc,
    this.icon,
    this.yesLoading = false,
  });
  final void Function() yesFunction;
  final String label;
  final String? desc;
  final Widget? icon;
  final bool yesLoading;

  @override
  State<CustomDialogDesign> createState() => _CustomDialogDesignState();
}

class _CustomDialogDesignState extends State<CustomDialogDesign> {
  late SystemUiOverlayStyle _previousStyle;

  @override
  void initState() {
    super.initState();
    // ignore: invalid_use_of_visible_for_testing_member
    _previousStyle = SystemChrome.latestStyle ?? const SystemUiOverlayStyle();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(_previousStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(
              0.1,
            ), // Optional: Add a slightly darker overlay
          ),
        ),
        Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VerticalSizedBox(vVerySmall),
                if (widget.icon != null) ...[
                  widget.icon!,
                  VerticalSizedBox(vBetweenTextFiled),
                ],
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: largeTitle,
                ),
                if (widget.desc != null) ...[
                  VerticalSizedBox(vVerySmall),
                  Text(
                    widget.desc ?? '',
                    textAlign: TextAlign.center,
                    style: mainTitle,
                  ),
                ],
                VerticalSizedBox(vVerySmall),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.greyBorderColor,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppBtn(
                        title:' S.of(context).cancel',
                        function: () => Navigator.pop(context),
                        btnColor: Colors.transparent,
                        textColor: AppColors.dangerColor,
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 55.h,
                      color:
                          AppColors
                              .greyBorderColor, // Divider color between buttons
                    ),
                    Expanded(
                      child: AppBtn(
                        title: 'S.of(context).yes',
                        isLoading: widget.yesLoading,
                        function: widget.yesFunction,
                        btnColor: Colors.transparent,
                        textColor: context.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
