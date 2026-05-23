import 'package:bus_mate_bd/app/assetsPath.dart';
import 'package:bus_mate_bd/app/extensions/language_extension.dart';
import 'package:bus_mate_bd/features/common/presentation/screens/bottom_main_nav_bar_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, BottomMainNavBarScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image(image: AssetImage(AssetsPath.splashLogoImage),width: 120),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 180),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Spacer(),
            Wrap(
              children: [
                Text(context.localization.versionWithNumber,style: TextStyle(color: Colors.grey),)
              ],
            ),
            SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
