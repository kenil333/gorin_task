import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_size.dart';

class AppStyle {
  static get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          shadowColor: AppColor.textPrimary.withValues(alpha: 0.25),
        ),
      );

  static const UnderlineInputBorder underlinBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColor.optionalButton),
    borderRadius: BorderRadius.zero,
  );

  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: underlinBorder,
    enabledBorder: underlinBorder,
    focusedBorder: underlinBorder,
    disabledBorder: underlinBorder,
  );

  static TextStyle font16400 = TextStyle(
    fontSize: AppSize.size16,
    fontWeight: FontWeight.w400,
    color: AppColor.textPrimary,
  );

  static TextStyle font20500 = TextStyle(
    fontSize: AppSize.size20,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimary,
  );

  static TextStyle font24600 = TextStyle(
    fontSize: AppSize.size24,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
  );

  static TextStyle font28600 = TextStyle(
    fontSize: AppSize.size28,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
  );
}
