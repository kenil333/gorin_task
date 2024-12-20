import 'package:flutter/material.dart';
import 'package:gorin_task/utils/extensions/locale_extension.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../utils/app_size.dart';
import '../../utils/app_style.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/common_loading.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTc = TextEditingController();
  final TextEditingController passwordTc = TextEditingController();
  final ValueNotifier<bool> allowSignInPress = ValueNotifier(false);
  final ValueNotifier<bool> obsecurePassword = ValueNotifier(false);

  /// Validates whether the email and password are both non-empty.
  /// Enables the sign-in button if both fields are filled.
  void checkEmailAndPassword() {
    if (emailTc.text.trim().isNotEmpty &&
        passwordTc.text.trim().isNotEmpty &&
        emailTc.text.validEmail &&
        passwordTc.text.length >= 8 &&
        passwordTc.text.length <= 16) {
      allowSignInPress.value = true;
    } else {
      allowSignInPress.value = false;
    }
  }

  /// Toggles the password visibility between obscured and visible.
  void onPasswordObsecurePressed() {
    obsecurePassword.value = !obsecurePassword.value;
  }

  @override
  void dispose() {
    emailTc.dispose();
    passwordTc.dispose();
    allowSignInPress.dispose();
    obsecurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.size20,
                      vertical: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppSize.topPadding),
                        Text(
                          context.l10n.login,
                          style: AppStyle.font28600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.l10n.enterYourEmailAndPassword,
                          style: AppStyle.font16400,
                        ),
                        const SizedBox(height: 40),
                        AppTextfield(
                          controller: emailTc,
                          lable: context.l10n.email,
                          hintText: context.l10n.email,
                          onChanged: (String value) {
                            checkEmailAndPassword();
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
                              checkEmailAndPassword();
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
                        const SizedBox(height: 80),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Text(
                              "${context.l10n.dontHaveAccount} ",
                              style: AppStyle.font16400.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()),
                                );
                              },
                              child: Text(
                                context.l10n.signUp,
                                style: AppStyle.font16400.copyWith(
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: allowSignInPress,
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
                                  Selector<AuthProvider, bool>(
                                    builder: (context, loading, child) =>
                                        AppButton(
                                      title: context.l10n.login,
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        context.read<AuthProvider>().login(
                                              email: emailTc.text.trim(),
                                              password: passwordTc.text.trim(),
                                              onSuccess: () {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen(),
                                                  ),
                                                  (route) => false,
                                                );
                                              },
                                            );
                                      },
                                      otherWidget: loading
                                          ? const CommonLoading()
                                          : null,
                                    ),
                                    selector: (context, ap) => ap.signInLoading,
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
            Selector<AuthProvider, bool>(
              builder: (context, loading, child) => loading
                  ? Container(
                      color: Colors.transparent,
                    )
                  : const SizedBox(),
              selector: (context, ap) => ap.signInLoading,
            ),
          ],
        ),
      ),
    );
  }
}
