import 'package:bus_mate_bd/app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    final screenWidth = MediaQuery.of(context).size.width;

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: screenWidth * 0.14,
      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white.withValues(alpha: 0.2),

        border: Border.all(color: primaryColor.withValues(alpha: 0.15)),

        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [
          SizedBox(width: 10),

          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: languageProvider.currentLocale.languageCode,
                style: const TextStyle(
                  color: Colors.white,
                ),
                isDense: true,

                icon: const Icon(
                  Icons.expand_more_rounded,
                  color: Colors.white,
                  size: 18,
                ),

                dropdownColor:
                  isDark ? const Color(0xFF252525) : Colors.white,

                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('En'),
                  ),
                  DropdownMenuItem(
                    value: 'bn',
                    child: Text('বাং'),
                  ),
                ],

                onChanged: (value) {
                  if (value != null) {
                    context.read<LanguageProvider>().changeLocale(
                      Locale(value),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
