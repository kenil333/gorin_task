import 'package:flutter/material.dart';

import 'app_text.dart';

class AppData {
  static ValueNotifier<Locale> currentLocale = ValueNotifier(
    const Locale(AppText.en),
  );
}
