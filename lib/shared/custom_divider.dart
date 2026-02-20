import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/themes/app_colors.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.height, this.color, this.thickness});
  final double? height, thickness;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height?.h,
      color: color ?? AppColors.primary,
      thickness: thickness ?? 1,
    );
  }
}
