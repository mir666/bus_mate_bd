import 'package:bus_mate_bd/app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {

    final provider =
    context.watch<LanguageProvider>();

    return PopupMenuButton<String>(

      initialValue:
      provider.currentLocale.languageCode,

      onSelected: (value) async {

        await provider.changeLocale(
          Locale(value),
        );
      },

      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(12),
      ),

      itemBuilder: (context) => const [

        PopupMenuItem(
          value: 'en',
          child: Text('English'),
        ),

        PopupMenuItem(
          value: 'bn',
          child: Text('বাংলা'),
        ),
      ],

      child: Container(

        padding:
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),

        decoration: BoxDecoration(

          color: Colors.white
              .withValues(alpha: 0.15),

          borderRadius:
          BorderRadius.circular(10),
        ),

        child: Row(

          mainAxisSize:
          MainAxisSize.min,

          children: [

            Text(

              provider.currentLocale.languageCode == 'en' ? 'EN' : 'বাং',

              style: const TextStyle(
                color: Colors.white,
                fontWeight:
                FontWeight.w600,
              ),
            ),

            const SizedBox(width: 4),

            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}