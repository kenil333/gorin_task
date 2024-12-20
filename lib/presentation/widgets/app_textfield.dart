import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_size.dart';
import '../../utils/app_style.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  final String? hintText;
  final bool isPasswordField;
  final bool isObsecured;
  final Function? onEyePressed;
  final TextInputType? keyboardType;
  final Widget? preffixWidget;
  final BoxConstraints? preffixConstraints;
  final Widget? suffixWidget;
  final BoxConstraints? suffixConstraints;
  final TextStyle? textStyle;
  final TextStyle? titleTextStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final void Function()? onTap;
  final bool isSmall;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;

  const AppTextfield({
    super.key,
    required this.controller,
    required this.lable,
    this.hintText,
    this.isPasswordField = false,
    this.isObsecured = false,
    this.onEyePressed,
    this.keyboardType,
    this.preffixWidget,
    this.preffixConstraints,
    this.suffixWidget,
    this.suffixConstraints,
    this.textStyle,
    this.titleTextStyle,
    this.contentPadding,
    this.onTap,
    this.validator,
    this.maxLines = 1,
    this.readOnly = false,
    this.isSmall = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: isSmall
              ? AppStyle.font16400
              : titleTextStyle ?? AppStyle.font20500,
        ),
        SizedBox(height: isSmall ? 2 : 6),
        TextFormField(
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onTap: onTap,
          controller: controller,
          obscureText: isObsecured,
          keyboardType:
              isPasswordField ? TextInputType.visiblePassword : keyboardType,
          style: isSmall ? AppStyle.font16400 : textStyle,
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyle.font16400.copyWith(
              color: AppColor.hintColor,
            ),
            prefixIcon: preffixWidget,
            prefixIconConstraints: preffixConstraints,
            suffixIconConstraints: suffixConstraints ??
                BoxConstraints(
                  maxHeight: AppSize.size24,
                  maxWidth: AppSize.size24,
                ),
            suffixIcon: suffixWidget ??
                (isPasswordField
                    ? GestureDetector(
                        onTap: () {
                          if (onEyePressed != null) {
                            onEyePressed!();
                          }
                        },
                        child: isObsecured
                            ? SvgPicture.asset(
                                AppImage.hideEyeIcon,
                                width: AppSize.size24,
                                colorFilter: const ColorFilter.mode(
                                  AppColor.primary,
                                  BlendMode.srcIn,
                                ),
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: AppColor.primary,
                                size: AppSize.size22,
                              ),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
