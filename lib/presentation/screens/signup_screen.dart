import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gorin_task/utils/extensions/locale_extension.dart';

import '../../helpers/image_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/app_size.dart';
import '../../utils/app_style.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';

class SignupScreen extends StatefulWidget {
  static const String id = "/SignupScreen";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameTc = TextEditingController();
  final TextEditingController emailTc = TextEditingController();
  final TextEditingController passwordTc = TextEditingController();
  final ValueNotifier<bool> allowSignUpPress = ValueNotifier(false);
  final ValueNotifier<bool> obsecurePassword = ValueNotifier(false);
  final ValueNotifier<File?> image = ValueNotifier(null);

  /// Toggles the password visibility between obscured and visible.
  void onPasswordObsecurePressed() {
    obsecurePassword.value = !obsecurePassword.value;
  }

  /// Validates whether the name, email and password are non-empty.
  /// Enables the sign-up button if all fields are filled.
  void onChangeNameEmailPassword() {
    if (nameTc.text.trim().isNotEmpty &&
        emailTc.text.trim().isNotEmpty &&
        passwordTc.text.trim().isNotEmpty &&
        emailTc.text.validEmail &&
        passwordTc.text.length >= 8 &&
        passwordTc.text.length <= 16 &&
        image.value != null) {
      allowSignUpPress.value = true;
    } else {
      allowSignUpPress.value = false;
    }
  }

  @override
  void dispose() {
    nameTc.dispose();
    emailTc.dispose();
    passwordTc.dispose();
    allowSignUpPress.dispose();
    obsecurePassword.dispose();
    image.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.size20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize.topPadding),
                    Text(
                      context.l10n.signUp,
                      style: AppStyle.font28600,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.provideNecessaryDetails,
                      style: AppStyle.font16400,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          image.value =
                              await ImageHelper.pickImage() ?? image.value;
                        },
                        child: Container(
                          width: AppSize.size.width * 0.3,
                          height: AppSize.size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColor.primary.withValues(alpha: 0.5),
                          ),
                          child: ValueListenableBuilder<File?>(
                            valueListenable: image,
                            builder: (context, pickedFile, child) =>
                                pickedFile != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          pickedFile,
                                          width: AppSize.size.width * 0.3,
                                          height: AppSize.size.width * 0.3,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.person_outline_rounded,
                                          size: AppSize.size48,
                                          color: AppColor.white,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextfield(
                      controller: nameTc,
                      lable: context.l10n.name,
                      hintText: context.l10n.name,
                      onChanged: (String value) {
                        onChangeNameEmailPassword();
                      },
                    ),
                    const SizedBox(height: 32),
                    AppTextfield(
                      controller: emailTc,
                      lable: context.l10n.email,
                      hintText: context.l10n.email,
                      onChanged: (String value) {
                        onChangeNameEmailPassword();
                      },
                      validator: (String? value) {
                        if (value != null && value.validEmail) {
                          return null;
                        } else {
                          return context.l10n.invalidEmail;
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    ValueListenableBuilder<bool>(
                      valueListenable: obsecurePassword,
                      builder: (context, obsecure, child) => AppTextfield(
                        controller: passwordTc,
                        lable: context.l10n.password,
                        hintText: context.l10n.password,
                        isPasswordField: true,
                        isObsecured: obsecure,
                        onEyePressed: () {
                          onPasswordObsecurePressed();
                        },
                        onChanged: (String value) {
                          onChangeNameEmailPassword();
                        },
                        validator: (String? value) {
                          if (value != null &&
                              value.length >= 8 &&
                              value.length <= 16) {
                            return null;
                          } else {
                            return context.l10n.invalidPassword;
                          }
                        },
                      ),
                    ),
                    // const SizedBox(height: 80),
                    // Row(
                    //   children: [
                    //     Expanded(child: Container()),
                    //     Text(
                    //       "${context.l10n.dontHaveAccount} ",
                    //       style: AppStyle.font16400.copyWith(
                    //         color: AppColor.textPrimary,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Text(
                    //         context.l10n.signUp,
                    //         style: AppStyle.font16400.copyWith(
                    //           color: AppColor.primary,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(child: Container()),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: allowSignUpPress,
              builder: (context, allow, child) => Visibility(
                visible: allow,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: AppSize.size20),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: AppColor.devider,
                              ),
                              const SizedBox(height: 24),
                              AppButton(
                                title: context.l10n.signUp,
                                onPressed: () {},
                                // otherWidget: controller.isApiRunning.value
                                //     ? const CommonButtonLoading()
                                //     : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppSize.size20),
                      ],
                    ),
                    SizedBox(height: AppSize.bottomPadding + 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
