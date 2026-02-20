import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HorizontalSizedBox extends StatelessWidget {
  const HorizontalSizedBox( this.width,{super.key,});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
    );
  }
}
