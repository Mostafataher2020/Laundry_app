import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/payment/presentation/views/credit_card_screen.dart';
import 'package:laundry_app/features/payment/presentation/views/payment_successful.dart';

class PaymentScreenBody extends StatefulWidget {
  const PaymentScreenBody({super.key});

  @override
  State<PaymentScreenBody> createState() => _PaymentScreenBodyState();
}

class _PaymentScreenBodyState extends State<PaymentScreenBody> {
  String? selectedMethod;
  bool showExtraButton = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Container(
                  height: size.height * 0.12,
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
                      context.tr('1.00 SR'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  context.tr('Choose your payment method'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  width: size.width * 0.75,
                  child: _buildPaymentButton(context, context.tr('Cash'), () {
                    setState(() {
                      selectedMethod = 'Cash';
                      showExtraButton = true;
                      print('Cash');
                    });
                  }),
                ),
                SizedBox(
                  width: size.width * 0.75,
                  child: _buildPaymentButton(context, context.tr('Credit Card'), () {
                    setState(() {
                      selectedMethod = 'Credit Card';
                      showExtraButton = true;
                      print('Credit Card');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreditCardScreen(),
                        ),
                      );
                    });
                  }),
                ),
                SizedBox(
                  width: size.width * 0.75,
                  child: _buildPaymentButton(context, context.tr('Apple Pay'), () {
                    setState(() {
                      selectedMethod = 'Apple Pay';
                      showExtraButton = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSuccessful(),
                        ),
                      );
                      print('Apple Pay');
                    });
                  }),
                ),
              ],
            ),
          ),
        ),
        if (showExtraButton) _buildExtraButton(selectedMethod!),
        SizedBox(height: size.height * 0.06),
      ],
    );
  }

  Widget _buildPaymentButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    bool isSelected = selectedMethod == text;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Color(0xFF084059) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExtraButton(String method) {
    String buttonText;
    Color buttonColor;
    switch (method) {
      case 'Cash':
        buttonText = context.tr('Done');
        buttonColor = Color(0xFFC09471);
        break;
      // case 'Credit Card':
      // buttonText = 'Enter Card Details';
      // buttonColor = Color(0xFFFCC99D);
      // break;
      // case 'Apple Pay':
      // buttonText = 'Proceed with Apple Pay';
      // buttonColor = Color(0xFFFCC99D);
      // break;
      default:
        return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        onPressed: () {},
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
