import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/features/payment/presentation/views/payment_successful.dart';

class CreditCardScreenBody
 extends StatefulWidget {
  const CreditCardScreenBody
  ({super.key});

  @override
  State<CreditCardScreenBody> createState() => _CreditCardScreenBodyState();
}

class _CreditCardScreenBodyState extends State<CreditCardScreenBody> {
    final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _saveCard = false;

  Future<String> _createPaymentIntent() async {
    final dio = Dio();
    try {
      final response = await dio.post(
        'http://your-server-address/create-payment-intent', // استبدل بعنوان الخادم
        data: { 'amount': int.parse(_amountController.text) * 100 }, // المبلغ بالسنوات
        options: Options(headers: { 'Content-Type': 'application/json' }),
      );
      return response.data['clientSecret'];
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }

  void _payNow() async {
    if (_formKey.currentState!.validate()) {
      final clientSecret = await _createPaymentIntent();
      final cardDetails = PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(
            name: _cardHolderNameController.text,
          ),
        ),
      );

      try {
        await Stripe.instance.confirmPayment(
          paymentIntentClientSecret: clientSecret,
          data: cardDetails,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Successful!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                      context.tr('Complete The Process'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      filled: true,
                            fillColor: Color.fromARGB(255, 227, 183, 118),
                      labelText: context.tr('Amount (SAR)'),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context.tr('Please enter the amount');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _cardHolderNameController,
                    decoration: InputDecoration(
                      filled: true,
                            fillColor: Color.fromARGB(255, 227, 183, 118),
                      labelText: context.tr('Cardholder Name'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context.tr('Please enter cardholder name');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      filled: true,
                            fillColor: Color.fromARGB(255, 227, 183, 118),
                      labelText: context.tr('Card Number'),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context.tr('Please enter card number');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 227, 183, 118),
                            labelText: context.tr('MM/YY'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return context.tr('Please enter expiry date');
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
        
                          controller: _cvvController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 227, 183, 118),
                            labelText: context.tr('CVV'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return context.tr('Please enter CVV');
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    activeColor: Color.fromARGB(255, 227, 183, 118),
                    title: Text(context.tr('Save the card')),
                    value: _saveCard,
                    onChanged: (value) {
                      setState(() {
                        _saveCard = value!;
                      });
                    },
                  ),
                  SizedBox(height: 70),
                  CustomButton(text: context.tr('Pay Now'), buttonAction: (){
                    _payNow();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentSuccessful(),),);
                  }, color: Color(0xFFC09471), width: double.infinity,),
                  SizedBox(height: 80),
                  // ElevatedButton(
                  //   onPressed: _payNow,
                  //   child: Text('Pay Now'),
                  //   style: ElevatedButton.styleFrom(
                  //     minimumSize: Size(double.infinity, 50),
                  //   ),
                  // ),
                ],
              ),
            ),
          
        ),
      ),
    );
  }
}