import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/language_service.dart';
import 'package:laundry_app/features/auth/presentation/views/sign_up_screen.dart';

class TranslateScreenBody extends StatefulWidget {
  const TranslateScreenBody({super.key});

  @override
  State<TranslateScreenBody> createState() => _TranslateScreenBodyState();
}

class _TranslateScreenBodyState extends State<TranslateScreenBody> {
  late StreamSubscription<Locale> _localeSubscription;

  @override
  void initState() {
    super.initState();
    _localeSubscription = LanguageService.localeStream.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _localeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 الخلفية (الصورة العلوية)
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  "assets/images/translate.png", // استبدل بالصورة الخاصة بك
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(), // فارغ لأخذ المساحة السفلية
              ),
            ],
          ),
        ),

        // 🔹 الجزء السفلي مع التدرج والضبابية
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFEAD7), Color(0xFFFFEAD7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  // 🔹 نص "اختر لغة"
                  Text(
                    context.tr('Select Language'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),

                  // 🔹 زر اللغة العربية
                  InkWell(
                    onTap: () {
                      if (context.locale.languageCode == 'en') {
                        LanguageService.changeLanguage(
                          context: context,
                          languageCode: 'ar',
                        );
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                      }

                    
                    },
                    child: buildLanguageButton(
                      context.tr('Arabic'),
                      Colors.white,
                      Colors.black,
                      widthFactor: 274,
                    ),
                  ),

                  SizedBox(height: 20),

                  // 🔹 زر اللغة الإنجليزية
                  InkWell(
                    onTap: () {
                      if (context.locale.languageCode == 'ar') {
                        LanguageService.changeLanguage(
                          context: context,
                          languageCode: 'en',
                        );
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                      }

                      
                    },
                    child: buildLanguageButton(
                      context.tr('English'),
                      Color(0xFF44C3BC),
                      Colors.black,
                      widthFactor: 274,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLanguageButton(
    String text,
    Color bgColor,
    Color textColor, {
    double widthFactor = double.infinity,
  }) {
    return Container(
      width: widthFactor, // التحكم في عرض الزر
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
