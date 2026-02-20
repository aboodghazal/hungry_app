import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dimintions.dart';


class AppPadding {
  static final horizontal = EdgeInsets.symmetric(
    horizontal: 20.w,
  );
  static final horizontalAndVertical = EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 16.h,
  );
  static final verySmallHorizontal = EdgeInsets.symmetric(horizontal: 5.w);

  static final SmallHorizontal = EdgeInsets.symmetric(horizontal: 14.w);

  static final vertical = EdgeInsets.symmetric(vertical: 16.h);
  static final verticalSmall = EdgeInsets.symmetric(vertical: vSmall.h);
  static final verticalBottomAndSmallTop = EdgeInsetsDirectional.only(
    bottom: 16.h,
    top: 10.h,
  );

  static final verticalBottom = EdgeInsetsDirectional.only(bottom: 20.h);
  static final smallVerticalBottom = EdgeInsetsDirectional.only(bottom: 10.h);
  static final verticalTop = EdgeInsetsDirectional.only(top: 16.h);

  static final containerPadding = EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 9.5.h,
  );


  static final containerPaddingStander = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  );
  static final smallContainerPadding = EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 4.h,
  );
  static final smallPadding = EdgeInsets.symmetric(
    horizontal: 8.w,
    vertical: 8.h,
  );
  static final verySmallPadding = EdgeInsets.symmetric(
    horizontal: 4.w,
    vertical: 4.h,
  );
  static final cardPadding = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 8.h,
  );
  static final smallEndPadding = EdgeInsetsDirectional.only(end: hSmall.w);
  static final defaultEndPadding = EdgeInsetsDirectional.only(
    end: 20.w,
  );
}
