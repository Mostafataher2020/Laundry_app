import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/onboarding/presentation/views/widgets/onboarding_body.dart';

class Onboarding
 extends StatelessWidget {
  const Onboarding
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      body: OnboardingBody(),
    );
  }
}   