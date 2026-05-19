
import 'package:bus_mate_bd/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings){
    late Widget widget;

    if(settings.name == SplashScreen.name){
      widget = SplashScreen();
    }

    return MaterialPageRoute(builder: (ctx) => widget);
  }
}