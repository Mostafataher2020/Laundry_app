import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageService {
  static final _localeStream = StreamController<Locale>.broadcast();
  
  static Stream<Locale> get localeStream => _localeStream.stream;

  static Future<void> changeLanguage({
    required BuildContext context,
    required String languageCode,
  }) async {
    try {
      final newLocale = Locale(languageCode);
      await context.setLocale(newLocale);
      _localeStream.add(newLocale); // إعلام كل الويدجتس بالتغيير
    } catch (e) {
      debugPrint('Language change error: $e');
    }
  }

  static void dispose() {
    _localeStream.close();
  }
}