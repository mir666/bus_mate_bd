import 'package:bus_mate_bd/app/app_routes.dart';
import 'package:bus_mate_bd/app/app_theme.dart';
import 'package:bus_mate_bd/app/providers/language_provider.dart';
import 'package:bus_mate_bd/app/providers/theme_provider.dart';
import 'package:bus_mate_bd/features/common/presentation/providers/main_nav_container_provider.dart';
import 'package:bus_mate_bd/features/favorite/providers/favorite_provider.dart';
import 'package:bus_mate_bd/features/home/providers/home_provider.dart';
import 'package:bus_mate_bd/features/map/providers/map_provider.dart';
import 'package:bus_mate_bd/features/notification/providers/notification_provider.dart';
import 'package:bus_mate_bd/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class BusMateBD extends StatefulWidget {
  const BusMateBD({super.key});

  @override
  State<BusMateBD> createState() => _BusMateBDState();
}

class _BusMateBDState extends State<BusMateBD> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..loadInitialLanguage(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider()..loadInitialThemeMode(),
        ),
        ChangeNotifierProvider(create: (_) => MainNavContainerProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider()..initFavoriteBox(),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider()..loadRoutes()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),

      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                onGenerateRoute: AppRoutes.routes,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.currentThemeMode,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [Locale('en'), Locale('bn')],
                locale: languageProvider.currentLocale,
              );
            },
          );
        },
      ),
    );
  }
}
