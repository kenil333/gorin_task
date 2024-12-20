import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_size.dart';

class AppButton extends StatelessWidget {
  final String title;
  final double height;
  final double? width;
  final Function? onPressed;
  final double? radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final Widget? otherWidget;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.title,
    this.height = 56,
    this.onPressed,
    this.radius,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.otherWidget,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: backgroundColor ?? AppColor.primary,
        foregroundColor: foregroundColor ?? AppColor.white,
        surfaceTintColor: backgroundColor ?? AppColor.primary,
        overlayColor: AppColor.primary.withValues(alpha: 0.01),
        shadowColor: AppColor.primary.withValues(alpha: 0.01),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 12),
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
        textStyle: TextStyle(
          fontSize: fontSize ?? AppSize.size20,
          fontWeight: fontWeight,
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: SizedBox(
        height: height,
        width: width,
        child: otherWidget ??
            Center(
              child: Text(title),
            ),
      ),
    );
  }
}
