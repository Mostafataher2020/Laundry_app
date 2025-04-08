import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/splash_screen/presentation/views/widgets/splash_screen_body.dart';

class SplashScreen
 extends StatelessWidget {
  const SplashScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      body: SplashScreenBody(),
    );
  }
}