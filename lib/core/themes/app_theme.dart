import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import '../constants/const_string.dart';
import 'app_colors.dart';

class AppTheme {
  static Locale? locale;
  static const double height = 1.5;

  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    scaffoldBackgroundColor: AppColors.scaffoldColor,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: _getFontFamily(),
    platform: TargetPlatform.iOS,
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.greyTextColor,
      ),
      overlayColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.greyTextColor,
      ),
      visualDensity: VisualDensity.compact,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        height: height,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryTextColor,
        fontFamily: _getFontFamily(),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.primary,
      ),
    ),

    // Text Theme
    textTheme: _buildTextTheme(),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.scaffoldColor
            : AppColors.greyTextColor,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.greyBorderColor,
      ),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: AppColors.greyHintColor, width: 1.5.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.scaffoldColor,
      ),
      checkColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.scaffoldColor
            : AppColors.greyBorderColor,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      minWidth: double.infinity,
      height: 60.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primaryButtonColor),
      ),
    ),
  );

  static TextTheme _buildTextTheme() {
    return TextTheme(
      titleLarge: _textStyle(30, FontWeight.w700),
      titleMedium: _textStyle(16, FontWeight.w700),
      titleSmall: _textStyle(14, FontWeight.w700),
      labelLarge: _textStyle(20, FontWeight.w400),
      bodyLarge: _textStyle(14, FontWeight.w400),
      bodyMedium: _textStyle(12, FontWeight.w400),
    );
  }

  static TextStyle _textStyle(
    double fontSize,
    FontWeight weight, {
    // double? heightPx,
    Color? color,
  }) {
    return TextStyle(
      // height:
      //     (heightPx != null
      //             ? (heightPx / (fontSize > 0 ? fontSize : 1))
      //             : height)
      //         .h,
      fontSize: fontSize.sp,
      fontWeight: weight,
      color: color ?? AppColors.primaryTextColor,
      fontFamily: _getFontFamily(),
    );
  }

  static String _getFontFamily() {
    return locale?.languageCode == 'ar' || locale?.languageCode == null
        ? arabicFontFamily
        : englishFontFamily;
  }
}
