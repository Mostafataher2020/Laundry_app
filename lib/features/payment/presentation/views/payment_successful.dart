import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';
import 'package:laundry_app/features/payment/presentation/views/widgets/payment_successful_body.dart';

class PaymentSuccessful
 extends StatelessWidget {
  const PaymentSuccessful
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      appBar: CustomAppBar(titles: context.tr('My Bill'), color: Colorss.applicationColor, backColor: Colors.black,),
      body: PaymentSuccessfulBody(),
    );
  }
}