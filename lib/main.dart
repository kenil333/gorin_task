import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'utils/app_color.dart';
import 'utils/app_data.dart';
import 'utils/app_style.dart';
import 'utils/app_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppText.gorinTask,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppData.currentLocale.value,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.primary,
          ),
          fontFamily: AppText.poppins,
          scaffoldBackgroundColor: AppColor.white,
          elevatedButtonTheme: AppStyle.elevatedButtonTheme,
          inputDecorationTheme: AppStyle.inputDecorationTheme,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
