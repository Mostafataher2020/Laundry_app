import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/build_text_field.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/core/widgets/texts.dart';
import 'package:laundry_app/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:laundry_app/features/location_screen/presentation/views/location_screen.dart';

class SignUpScreenBody extends StatefulWidget {
  const SignUpScreenBody({super.key});

  @override
  State<SignUpScreenBody> createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  final _formKey = GlobalKey<FormState>();
  String displayedText = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isNameEmpty = false;
  bool isPhoneEmpty = false;
  bool isEmailEmpty = false;

  void validateAndSubmit() {
    setState(() {
      isNameEmpty = nameController.text.isEmpty;
      isPhoneEmpty = phoneController.text.isEmpty;
      isEmailEmpty = emailController.text.isEmpty;
    });

    if (!isNameEmpty && !isPhoneEmpty && !isEmailEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
      );
    }
  }

  void updateText(String newText) {
    setState(() {
      displayedText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmallScreen = constraints.maxHeight < 600;
          final double imageHeight = isSmallScreen ? constraints.maxHeight * 0.25 : constraints.maxHeight * 0.3;
          final double formHeight = constraints.maxHeight - imageHeight;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // الصورة العلوية
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/auth.png",
                        width: double.infinity,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // النموذج
                    Positioned(
                      top: imageHeight - 30,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: formHeight,
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 15 : 20,
                            vertical: isSmallScreen ? 15 : 30,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // الحقول
                                BuildTextField(
                                  label: context.tr('Name'),
                                  hint: context.tr('Enter your name'),
                                  controller: nameController,
                                  onChanged: (value) => setState(() => isNameEmpty = value.isEmpty),
                                  onTap: () => updateText(context.tr('Enter a valid name')),
                                  isError: isNameEmpty, topMargin: isSmallScreen ? 8 : 12,
                                ),

                                SizedBox(height: isSmallScreen ? 4 : 8),

                                BuildTextField(
                                  label: context.tr('Phone'),
                                  hint: context.tr('Enter your phone number'),
                                  controller: phoneController,
                                  onChanged: (value) => setState(() => isPhoneEmpty = value.isEmpty),
                                  onTap: () => updateText(context.tr('Enter a valid phone number')),
                                  isError: isPhoneEmpty, topMargin: isSmallScreen ? 8 : 12,
                                ),

                                SizedBox(height: isSmallScreen ? 4 : 8),

                                BuildTextField(
                                  label: context.tr('E-mail'),
                                  hint: context.tr('Enter your email'),
                                  controller: emailController,
                                  onChanged: (value) => setState(() => isEmailEmpty = value.isEmpty),
                                  onTap: () => updateText(context.tr('Enter a valid email')),
                                  isError: isEmailEmpty, topMargin: isSmallScreen ? 8 : 12,
                                ),

                                // المسافة قبل الزر
                                SizedBox(height: constraints.maxHeight * 0.10),

                                // النص التحذيري
                                if (displayedText.isNotEmpty)
                                  Texts(
                                    text: displayedText,
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),

                                SizedBox(height: isSmallScreen ? 20 : 50),

                                // زر التالي
                                 Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      child: CustomButton(
                        text: context.tr('Next'),
                        buttonAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OtpVerificationScreen(),
                            ),
                          );
                        },
                        color: const Color(0xFFC09471), width: double.infinity,
                      ),
                    ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}