import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/shared/vertical_sized_box.dart';

import '../core/assets/assets.gen.dart';
import '../core/themes/custom_text_style.dart';
import '../core/themes/dimintions.dart';
import 'app_btn.dart';



class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.icon,
    required this.label,
    this.btnString,
    this.function,
  });
  final SvgGenImage? icon;
  final String label;
  final String? btnString;
  final void Function()? function;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!.svg(height: 100.h, width: 100.w),
            VerticalSizedBox(vBetweenItem),
          ],
          Text(label, style: mainBody),
          if (btnString != null) ...[
            VerticalSizedBox(vBetweenWidgetAndButton),
            AppBtn(title: btnString!, function: function ?? () {}),
          ],
        ],
      ),
    );
  }
}
