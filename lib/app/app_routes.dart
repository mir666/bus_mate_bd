import 'package:bus_mate_bd/features/auth/presentation/screens/splash_screen.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_list_screen.dart';
import 'package:bus_mate_bd/features/common/presentation/screens/bottom_main_nav_bar_screen.dart';
import 'package:bus_mate_bd/features/favorite/presentation/screen/favorite_screen.dart';
import 'package:bus_mate_bd/features/home/presentation/screens/home_screen.dart';
import 'package:bus_mate_bd/features/map/presentation/screens/map_screen.dart';
import 'package:bus_mate_bd/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings){
    late Widget widget;

    if(settings.name == SplashScreen.name){
      widget = const SplashScreen();
    } else if(settings.name == HomeScreen.name){
      widget = const HomeScreen();
    } else if(settings.name == BottomMainNavBarScreen.name){
      widget = const BottomMainNavBarScreen();
    } else if(settings.name == MapScreen.name){
      widget = const MapScreen();
    } else if(settings.name == BusListScreen.name){
      widget = const BusListScreen();
    } else if(settings.name == FavoriteScreen.name){
      widget = const FavoriteScreen();
    } else if(settings.name == SettingsScreen.name){
      widget = const SettingsScreen();
    } else if(settings.name == BusDetailsScreen.name){
      widget = const BusDetailsScreen();
    }

    return MaterialPageRoute(builder: (ctx) => widget);
  }
}