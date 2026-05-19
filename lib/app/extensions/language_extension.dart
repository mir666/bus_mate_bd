import 'package:bus_mate_bd/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension LanguageExtension on BuildContext{
  AppLocalizations get localization{
    return AppLocalizations.of(this)!;
  }
}