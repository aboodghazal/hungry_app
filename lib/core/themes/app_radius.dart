import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRadius {
  static final smallRadius = BorderRadius.circular(5.r);
  static final mediumRadius = BorderRadius.circular(12.r);
  static final veryMediumRadius = BorderRadius.circular(15.r);
  static final r100Radius = BorderRadius.circular(100.r);
  static final r30Radius = BorderRadius.circular(30.r);
  static final textFiledRadius = BorderRadius.circular(8.r);
  static final topMediumRadius = BorderRadius.only(
    topLeft: Radius.circular(12.r),
    topRight: Radius.circular(12.r),
  );
  static final topVeryLargeRadius = BorderRadius.only(
    topLeft: Radius.circular(25.r),
    topRight: Radius.circular(25.r),
  );
  static final largeRadius = BorderRadius.circular(20.r);
  static final veryLargeRadius = BorderRadius.circular(25.r);
  static final smallBottomRadius = BorderRadius.only(
    bottomLeft: Radius.circular(5.r),
    bottomRight: Radius.circular(5.r),
  );

  static final smallBottomRadiusAndTopEnd = BorderRadiusDirectional.only(
    bottomEnd: Radius.circular(5.r),
    topEnd: Radius.circular(5.r),
  );
  static final endMediumRadius = BorderRadiusDirectional.only(
    topEnd: Radius.circular(12.r),
    bottomEnd: Radius.circular(12.r),
  );
  static final startMediumRadius = BorderRadiusDirectional.only(
    topStart: Radius.circular(12.r),
    bottomStart: Radius.circular(12.r),
  );
  static final veryLargeBottomRadius = BorderRadius.only(
    bottomLeft: Radius.circular(25.r),
    bottomRight: Radius.circular(25.r),
  );
}
