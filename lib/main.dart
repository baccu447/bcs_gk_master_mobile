import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/theme/app_theme.dart';
import 'app/modules/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  
  // Initialize Google Mobile Ads
  await MobileAds.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BCS/GK Master',
      theme: AppTheme.premiumDarkTheme,
      home: const SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
