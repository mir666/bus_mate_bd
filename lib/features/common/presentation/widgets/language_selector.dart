import 'package:bus_mate_bd/app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        DropdownMenu<String>(
          initialSelection: context
              .read<LanguageProvider>()
              .currentLocale
              .languageCode,
          onSelected: (String? language) {
            context.read<LanguageProvider>().changeLocale(Locale(language!));
          },
          dropdownMenuEntries: [
            DropdownMenuEntry(value: 'en', label: 'EN'),
            DropdownMenuEntry(value: 'bn', label: 'বাং'),
          ],
        ),
      ],
    );
  }
}
