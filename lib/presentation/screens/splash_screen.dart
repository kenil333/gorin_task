// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_size.dart';
import '../widgets/common_loading.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginScreen.id,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSize.setupData(MediaQuery.of(context));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppImage.appIcon,
                    width: AppSize.size.width * 0.4,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Expanded(child: SizedBox()),
              CommonLoading(
                color: AppColor.primary.withValues(alpha: 0.8),
              ),
              SizedBox(height: AppSize.bottomPadding + 24),
            ],
          ),
        ],
      ),
    );
  }
}
