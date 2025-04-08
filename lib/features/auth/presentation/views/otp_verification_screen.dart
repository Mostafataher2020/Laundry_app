import 'package:flutter/material.dart';
import 'package:laundry_app/features/auth/presentation/views/widgets/otp_verification_screen_body.dart';

class OtpVerificationScreen
 extends StatelessWidget {
  const OtpVerificationScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpVerificationScreenBody(),
    );
  }
}