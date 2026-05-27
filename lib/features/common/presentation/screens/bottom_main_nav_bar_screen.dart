import 'package:bus_mate_bd/app/app_colors.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_list_screen.dart';
import 'package:bus_mate_bd/features/common/presentation/providers/main_nav_container_provider.dart';
import 'package:bus_mate_bd/features/favorite/presentation/screen/favorite_screen.dart';
import 'package:bus_mate_bd/features/home/presentation/screens/home_screen.dart';
import 'package:bus_mate_bd/features/map/presentation/screens/map_screen.dart';
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
    HomeScreen(),
    MapScreen(),
    BusListScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer<MainNavContainerProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          extendBody: true, // important for floating effect


          body: _screens[nav.selectedIndex],

          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(
              left: 14,
              right: 14,
              bottom: 22,
            ),
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF0F172A) : Color(0xFFF6F7FB),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            // 👇 THIS IS THE MAIN FIX
            child: SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0,

                  currentIndex: nav.selectedIndex,
                  onTap: nav.changeItem,

                  selectedItemColor: AppColors.themeColor,
                  unselectedItemColor: Colors.grey.shade500,

                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.2,
                  ),

                  unselectedLabelStyle: const TextStyle(
                    fontSize: 11,
                    height: 1.2,
                  ),

                  iconSize: 26,

                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map_outlined),
                      label: 'Map',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.directions_bus_sharp),
                      label: 'Bus List',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border_outlined),
                      label: 'Favorite',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}