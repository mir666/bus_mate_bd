import 'package:bus_mate_bd/app/assetsPath.dart';
import 'package:bus_mate_bd/features/home/presentation/widgets/drawer_header.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            AppDrawerHeader(),

            _drawerItem(
              context,
              icon: Icons.home_rounded,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _drawerItem(
              context,
              icon: Icons.favorite_rounded,
              title: 'Favorites',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _drawerItem(
              context,
              icon: Icons.history_rounded,
              title: 'Recent Searches',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Divider(),

            _drawerItem(
              context,
              icon: Icons.language_rounded,
              title: 'Language',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _drawerItem(
              context,
              icon: isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              title: 'Dark Mode',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Spacer(),

            const Divider(),

            _drawerItem(
              context,
              icon: Icons.share_rounded,
              title: 'Share App',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _drawerItem(
              context,
              icon: Icons.info_outline_rounded,
              title: 'About',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Bus Mate BD',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2026 Bus Mate BD',
                );
              },
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Row(
              children: [

                // Icon Container
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(
                      alpha: isDark ? 0.18 : 0.10,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 14),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}