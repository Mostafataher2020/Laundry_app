import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/auth/presentation/views/widgets/sign_up_screen_body.dart';

class SignUpScreen
 extends StatelessWidget {
  const SignUpScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      body: SignUpScreenBody(),
    );
  }
}