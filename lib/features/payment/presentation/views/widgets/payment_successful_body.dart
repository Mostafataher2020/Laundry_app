import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';

class PaymentSuccessfulBody extends StatelessWidget {
  const PaymentSuccessfulBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.04),
          // الأيقونة
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Image.asset(
              'assets/images/success.png', // ضع الأيقونة الصحيحة هنا
              width: 120,
              height: 120,
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          // صندوق الرسالة
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
            height: screenHeight * 0.12,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colorss.applicationColor],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                context.tr('Payment successful'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          Spacer(),
          SizedBox(height: 20),

          // زر تحميل الفاتورة
          SizedBox(
            width: screenWidth * 0.8,
            child: CustomButton(text: context.tr('Download Bill'), buttonAction: () {}, color: Color(0xFFC09471), width: screenWidth,)),
            SizedBox(height: screenHeight * 0.2,)
        ],
      ),
    );
  }
}
