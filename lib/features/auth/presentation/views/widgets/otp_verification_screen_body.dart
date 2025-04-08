import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/core/widgets/texts.dart';
import 'package:laundry_app/features/location_screen/presentation/views/location_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreenBody extends StatefulWidget {
  const OtpVerificationScreenBody({super.key});

  @override
  State<OtpVerificationScreenBody> createState() =>
      _OtpVerificationScreenBodyState();
}

class _OtpVerificationScreenBodyState extends State<OtpVerificationScreenBody> {
  String displayedText = '';
  TextEditingController otpController = TextEditingController();
  int countdown = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() => canResend = false);
    countdown = 60;
    Future.delayed(const Duration(seconds: 1), countdownTick);
  }

  void countdownTick() {
    if (countdown > 0 && mounted) {
      setState(() => countdown--);
      Future.delayed(const Duration(seconds: 1), countdownTick);
    } else if (mounted) {
      setState(() => canResend = true);
    }
  }

  void sendOtpAgain() {
    print("🔄 Resending OTP...");
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      body: Stack(
        children: [
          // الخلفية العلوية (الصورة)
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: isSmallScreen ? 2 : 3,
                  child: Image.asset(
                    "assets/images/auth.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Expanded(flex: 3, child: SizedBox()),
              ],
            ),
          ),

          // زر الرجوع

          // البطمة السفلية (النموذج)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.6, // نفس ارتفاع صفحة SignUp
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFEAD7), Color(0xFFFFEAD7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: isSmallScreen ? 15 : 25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // العنوان
                    Texts(
                      text: context.tr('Verify Phone Number'),
                      color: const Color(0xFF4D758A),
                      fontSize: isSmallScreen ? 22 : 24,
                    ),
                    SizedBox(height: isSmallScreen ? 5 : 10),

                    // النص التوضيحي
                    Texts(
                      text: context.tr(
                        'Enter the OTP sent to your phone number',
                      ),
                      color: Colors.black54,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 30),

                    // حقول OTP
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 30,
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        controller: otpController,
                        pinTheme: PinTheme(
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                          selectedColor: Colors.white,

                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: isSmallScreen ? 45 : 50,
                          fieldWidth: isSmallScreen ? 45 : 50,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.blue[100],
                          activeBoxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        onChanged: (value) {
                          if (value.length == 4) {
                            setState(() => displayedText = '');
                          }
                        },
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 15 : 20),

                    // إعادة الإرسال
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.tr('Send again?'),
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          canResend ? '' : "$countdown ${context.tr('sec')}",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (canResend)
                          GestureDetector(
                            onTap: sendOtpAgain,
                            child: Text(
                              context.tr('Resend'),
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 14,
                                color: const Color(0xFFC09471),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height:
                          isSmallScreen
                              ? size.height * 0.0
                              : size.height * 0.08,
                    ),

                    // زر التالي
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 30 : 50,
                      ),
                      child: CustomButton(
                        text: context.tr('Next'),
                        buttonAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationScreen(),
                            ),
                          );
                        },
                        color: const Color(0xFFC09471),
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
