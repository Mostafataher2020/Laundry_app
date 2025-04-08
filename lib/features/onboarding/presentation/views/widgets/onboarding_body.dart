import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/translate_screen/presentation/views/translate_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "animation": "assets/images/swam.jpg",
      "title": "توصيل سريع وسهل !",
      "description": "اطلب غسيل ملابسك وسنقوم بالتوصيل اليك في الوقت والمكان الذي يناسبك .",
    },
    {
      "animation": "assets/images/swam.jpg",
      "title": "ودع عناء الغسيل !",
      "description": "مع خدماتنا السريعه نوفر لك غسيل نظيف ومنعش بدون اي مجهود .",
    },
    {
      "animation": "assets/images/swam.jpg",
      "title": "نظافه فائقة بأسعار مناسبة !",
      "description": "نستخدم أفضل المواد والتنظيف الاحترافي للحفاظ علي ملابسك بأعلي جودة .",
    },
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: width ,
                    height: height * 0.45,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(_onboardingData[index]["animation"]!), fit: BoxFit.fill),
                    )
                    ,
                    // child: Image.asset(_onboardingData[index]["animation"]!),
                  ),
                   SizedBox(height: height * 0.25),
                  Text(
                    _onboardingData[index]["title"]!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _onboardingData[index]["description"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(_onboardingData.length - 1);
                  },
                  child: Container(
                    width: width * 0.15,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.white, width: 2),
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Icon(Icons.arrow_forward, color: Colors.white,)),
                  ),
                ),
                Row(
                  children: List.generate(_onboardingData.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentIndex == index ? 12 : 8,
                      height: _currentIndex == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index
                                ? Colors.black
                                : Colors.grey.shade400,
                      ),
                    );
                  }),
                ),

                InkWell(
                  onTap: () {
                    if (_currentIndex < _onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TranslateScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: width * 0.30,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text(_currentIndex == _onboardingData.length - 1 ? "انشاء حساب" : "التالي", 
                    style: TextStyle(color: Colors.white, fontSize: 16),)),
                  ),
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Text(
//                     _currentIndex == _onboardingData.length - 1
//                         ? "ابدأ"
//                         : "التالي",
//                   ),




// TextButton(
//                   onPressed: () {
//                     if (_currentIndex < _onboardingData.length - 1) {
//                       _pageController.nextPage(
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.ease,
//                       );
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TranslateScreen(),
//                         ),
//                       );
//                     }
//                   },
//                   child: Container(
//                     width: width * 0.3,
//                     height: height * 0.06,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.black,
//                       border: Border.all(color: Colors.white, width: 2),
//                       // borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(
//                         _currentIndex == _onboardingData.length - 1
//                             ? "ابداء"
//                             : "التالي",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   )
//                 ),