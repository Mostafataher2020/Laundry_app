import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/onboarding/presentation/views/widgets/onboarding_body.dart';
import 'package:laundry_app/features/translate_screen/presentation/views/translate_screen.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingBody(),),);
    });
  }

  /*************  ✨ Codeium Command ⭐  *************/
  /// Returns a [Stack] widget containing the UI for the splash screen.
  /******  380aeda6-6f3a-44e8-9523-349c21e19352  *******/
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// الخلفية الزرقاء
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colorss.applicationColor, // لون الخلفية (عدّله حسب الحاجة)
        ),

        /// 3 صور فقاعات المياه (عدّل المسارات حسب صورك)
        Positioned(
          top: 474.15,
          left: 209.88,
          width: 120.66,
          height: 120.66,
          child: Transform.scale(
            scaleX: -1, // قلب الصورة أفقيًا
            child: Image.asset('assets/images/splash1.png', width: 100),
          ),
        ),
        Positioned(
          top: 150,
          right: 40,
          child: Image.asset(
            'assets/images/splash1.png', // ثاني صورة
            width: 120,
          ),
        ),
        Positioned(
          top: 620,
          left: 24,
          width: 178,
          height: 178,
          child: Image.asset(
            'assets/images/splash4.png', // ثالث صورة
            width: 178,
          ),
        ),

        /// الصورة الرئيسية في المنتصف
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/splash2.png', // الصورة الرئيسية (اللوجو)
                width: 270,
              ),
              SizedBox(height: 16), // مسافة بين الصورة والنصوص
            ],
          ),
        ),
      ],
    );
  }
}
