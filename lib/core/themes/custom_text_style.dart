

import 'package:huungry/core/themes/context.dart';
import 'package:flutter/material.dart';

 import '../routes/go_routes.dart';
import 'app_colors.dart';



TextStyle veryLargeTitle = navigatorKey.currentContext!.veryLargeTitle;
TextStyle largeTitle = navigatorKey.currentContext!.largeTitle;
TextStyle mainTitle = navigatorKey.currentContext!.mainTitle;
TextStyle largeBody = navigatorKey.currentContext!.largeBody;
TextStyle mainBody = navigatorKey.currentContext!.mainBody;
TextStyle smallBody = navigatorKey.currentContext!.smallBody;

TextStyle veryLargeTitleGreyColor = veryLargeTitle.copyWith(
  color: AppColors.primary,
);
TextStyle largeTitleGreyColor = largeTitle.copyWith(
  color: AppColors.primary,
);


TextStyle mainTitleGreyColor = mainTitle.copyWith(
  color: AppColors.primary,
);




