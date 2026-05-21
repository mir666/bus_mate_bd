import 'package:bus_mate_bd/features/auth/presentation/screens/splash_screen.dart';
import 'package:bus_mate_bd/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings){
    late Widget widget;

    if(settings.name == SplashScreen.name){
      widget = const SplashScreen();
    } else if(settings.name == HomeScreen.name){
      widget = const HomeScreen();
    }

    return MaterialPageRoute(builder: (ctx) => widget);
  }
}