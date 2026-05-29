import 'package:bus_mate_bd/app/extensions/language_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bus_mate_bd/app/providers/language_provider.dart';
import 'package:bus_mate_bd/app/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String name = '/settings';

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    final themeProvider = context.watch<ThemeProvider>();

    final isDark = themeProvider.currentThemeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF5F7FB),

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// =========================
          /// APP BAR
          /// =========================
          SliverAppBar(
            expandedHeight: 80,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),

              title: Text(
                context.localization.settings,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              centerTitle: true,
            ),
          ),

          /// =========================
          /// BODY
          /// =========================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// APPEARANCE
                  _sectionTitle(
                    title: context.localization.appearance,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 12),
                  _glassContainer(
                    isDark: isDark,
                    child: Column(
                      children: [
                        _themeTile(
                          context: context,
                          icon: Icons.phone_android,
                          title: context.localization.systemDefault,
                          value: ThemeMode.system,
                          currentValue: themeProvider.currentThemeMode,
                          isDark: isDark,
                        ),
                        _divider(isDark),
                        _themeTile(
                          context: context,
                          icon: Icons.light_mode_rounded,
                          title: context.localization.lightMode,
                          value: ThemeMode.light,
                          currentValue: themeProvider.currentThemeMode,
                          isDark: isDark,
                        ),
                        _divider(isDark),
                        _themeTile(
                          context: context,
                          icon: Icons.dark_mode_rounded,
                          title: context.localization.darkMode,
                          value: ThemeMode.dark,
                          currentValue: themeProvider.currentThemeMode,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// LANGUAGE
                  _sectionTitle(
                    title: context.localization.language,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 12),
                  _glassContainer(
                    isDark: isDark,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: _leadingIcon(icon: Icons.language_rounded),
                      title: Text(
                        context.localization.appLanguage,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),

                      subtitle: Text(
                        languageProvider.currentLocale.languageCode == 'en'
                            ? 'English'
                            : 'বাংলা',

                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),

                      trailing: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: languageProvider.currentLocale.languageCode,
                          dropdownColor: isDark
                              ? const Color(0xFF1E293B)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(14),
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(
                                'English',
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),

                            DropdownMenuItem(
                              value: 'bn',
                              child: Text(
                                'বাংলা',
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],

                          onChanged: (value) {
                            if (value == null) return;
                            languageProvider.changeLocale(Locale(value));
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// MORE
                  _sectionTitle(
                    title: context.localization.more,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 12),

                  _glassContainer(
                    isDark: isDark,
                    child: Column(
                      children: [
                        _settingsTile(
                          icon: Icons.favorite_rounded,
                          title: context.localization.favoriteRoutes,
                          subtitle: context.localization.manageSavedRoutes,
                          isDark: isDark,
                          onTap: () {},
                        ),

                        _divider(isDark),
                        _settingsTile(
                          icon: Icons.notifications_active_rounded,
                          title: context.localization.notifications,
                          subtitle: context.localization.busAlerts,
                          isDark: isDark,
                          onTap: () {},
                        ),

                        _divider(isDark),
                        _settingsTile(
                          icon: Icons.info_outline_rounded,
                          title: context.localization.aboutApp,
                          subtitle: context.localization.versionWithNumber,
                          isDark: isDark,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// SECTION TITLE
  /// =========================

  Widget _sectionTitle({required String title, required bool isDark}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
      ),
    );
  }

  /// =========================
  /// GLASS CONTAINER
  /// =========================

  Widget _glassContainer({required Widget child, required bool isDark}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,

        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.04),
        ),

        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),

      child: child,
    );
  }

  /// =========================
  /// DIVIDER
  /// =========================

  Widget _divider(bool isDark) {
    return Divider(
      height: 1,
      color: isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.06),
    );
  }

  /// =========================
  /// LEADING ICON
  /// =========================

  Widget _leadingIcon({required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB).withValues(alpha: 0.1),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Icon(icon, color: const Color(0xFF2563EB)),
    );
  }

  /// =========================
  /// THEME TILE
  /// =========================

  Widget _themeTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required ThemeMode value,
    required ThemeMode currentValue,
    required bool isDark,
  }) {
    return RadioListTile<ThemeMode>(
      value: value,
      groupValue: currentValue,
      activeColor: const Color(0xFF2563EB),
      onChanged: (newValue) {
        if (newValue == null) return;
        context.read<ThemeProvider>().changeThemeMode(newValue);
      },

      secondary: _leadingIcon(icon: icon),

      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  /// =========================
  /// SETTINGS TILE
  /// =========================

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      leading: _leadingIcon(icon: icon),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),

      subtitle: Text(
        subtitle,
        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
        color: isDark ? Colors.white70 : Colors.black54,
      ),
    );
  }
}
