import 'package:bus_mate_bd/app/app_colors.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_list_screen.dart';
import 'package:bus_mate_bd/features/common/presentation/providers/main_nav_container_provider.dart';
import 'package:bus_mate_bd/features/home/presentation/screens/home_screen.dart';
import 'package:bus_mate_bd/features/map/presentation/screens/map_screen.dart';
import 'package:bus_mate_bd/features/notification/presentation/screens/notification_screen.dart';
import 'package:bus_mate_bd/features/settings/presentation/screens/settings_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomMainNavBarScreen extends StatefulWidget {
  const BottomMainNavBarScreen({super.key});

  static const String name = '/bottom-nav-bar';

  @override
  State<BottomMainNavBarScreen> createState() => _BottomMainNavBarScreenState();
}

class _BottomMainNavBarScreenState extends State<BottomMainNavBarScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const BusListScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MainNavContainerProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          extendBody: true,

          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _screens[nav.selectedIndex],
          ),

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),

            child: Container(
              height: 74,

              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  _navItem(
                    context: context,
                    icon: Icons.home_outlined,
                    label: "",
                    index: 0,
                    selected: nav.selectedIndex == 0,
                    onTap: () => nav.changeItem(0),
                  ),

                  _navItem(
                    context: context,
                    icon: Icons.map_outlined,
                    label: "",
                    index: 1,
                    selected: nav.selectedIndex == 1,
                    onTap: () => nav.changeItem(1),
                  ),

                  _navItem(
                    context: context,
                    icon: Icons.directions_bus_rounded,
                    label: "",
                    index: 2,
                    selected: nav.selectedIndex == 2,
                    onTap: () => nav.changeItem(2),
                  ),

                  _navItem(
                    context: context,
                    icon: Icons.notifications_none,
                    label: "",
                    index: 3,
                    selected: nav.selectedIndex == 3,
                    onTap: () => nav.changeItem(3),
                  ),

                  _navItem(
                    context: context,
                    icon: Icons.settings_rounded,
                    label: "",
                    index: 4,
                    selected: nav.selectedIndex == 4,
                    onTap: () => nav.changeItem(4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _navItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),

        onTap: onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,

          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

          decoration: BoxDecoration(
            color: selected
                ? AppColors.themeColor.withOpacity(0.12)
                : Colors.transparent,

            borderRadius: BorderRadius.circular(18),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                icon,
                size: 24,
                color: selected ? AppColors.themeColor : Colors.grey,
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 250),

                child: selected
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),

                        child: Text(
                          label,

                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
