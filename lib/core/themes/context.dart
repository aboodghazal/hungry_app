import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Size get sizePage => MediaQuery.of(this).size;

  // TextStyles مع قيم افتراضية
  TextStyle get veryLargeTitle =>
      Theme.of(this).textTheme.titleLarge ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  TextStyle get largeTitle =>
      Theme.of(this).textTheme.titleMedium ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);

  TextStyle get mainTitle =>
      Theme.of(this).textTheme.titleSmall ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  TextStyle get largeBody =>
      Theme.of(this).textTheme.labelLarge ?? const TextStyle(fontSize: 16);

  TextStyle get mainBody =>
      Theme.of(this).textTheme.bodyLarge ?? const TextStyle(fontSize: 15);

  TextStyle get smallBody =>
      Theme.of(this).textTheme.bodyMedium ?? const TextStyle(fontSize: 13);

  // الألوان
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get lightMedium => Theme.of(this).highlightColor;
  Color get cardColor => Theme.of(this).cardColor;

  // وضع الداكن
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

// مثال RTL (معلق)
// bool get isRTL => AppController.instance.getLanguageCode() == arabicCode;
}
