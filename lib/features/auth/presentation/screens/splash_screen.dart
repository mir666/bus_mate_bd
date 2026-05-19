import 'package:bus_mate_bd/app/assetsPath.dart';
import 'package:bus_mate_bd/app/extensions/language_extension.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image(image: AssetImage(AssetsPath.splashLogoImage), width: 120),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 160),
              child: LinearProgressIndicator(
                color: Color(0xFFFC8914),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Spacer(),
            Wrap(
              children: [
                Text(
                  context.localization.versionWithNumber,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
