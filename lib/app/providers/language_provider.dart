import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {

  final String _localeKey = 'locale';

  Locale _currentLocale = Locale('bn');

  Locale get currentLocale => _currentLocale;

  Future<void> loadInitialLanguage() async {

    _currentLocale = await _getLocale();

    notifyListeners();
  }

  Future<void> changeLocale(Locale newLocale) async {

    if (_currentLocale == newLocale) {
      return;
    }

    _currentLocale = newLocale;

    notifyListeners();

    await _saveLocale(newLocale.languageCode);
  }

  Future<void> _saveLocale(String locale) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_localeKey, locale);
  }

  Future<Locale> _getLocale() async {

    final prefs = await SharedPreferences.getInstance();

    final savedLocale = prefs.getString(_localeKey) ?? 'en';

    return Locale(savedLocale);
  }
}