import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {

  final String _localeKey = 'locale';

  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  Future<void> loadInitialLanguage() async {
    Locale locale = await _getLocale();
    _currentLocale = locale;
    notifyListeners();
  }

  void changeLocale(Locale newLocale){
    if(_currentLocale == newLocale) return;

    _currentLocale = newLocale;
    _saveLocale(_currentLocale.languageCode);
    notifyListeners();
  }

  Future<void> _saveLocale(String local) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_localeKey, local);
  }

  Future<Locale> _getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String saveLocale = sharedPreferences.getString(_localeKey) ?? 'en';
    return Locale(saveLocale);
  }
}