import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/language_service.dart';
import 'package:laundry_app/features/order_screen/presentation/views/price_list_screen.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/widgets/halp_screen.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/widgets/my_location.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/widgets/my_previous_ordes_screen.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/widgets/save_card_screen.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/widgets/terms_conditions_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreenBody extends StatelessWidget {
  const UserProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colorss.applicationColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "${context.tr('Customer ID')} : #964563",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 227, 183, 118),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                buildProfileOption(context, context.tr('My Location'), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLocation()),
                  );
                  print("Navigating to My Location");
                }),
                buildProfileOption(context, context.tr('Price list'), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PriceListScreen()),
                  );
                  print("Opening Price List");
                }),
                buildProfileOption(context, context.tr('Saved Cards'), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SaveCardScreen()),
                  );
                  print("Viewing Saved Cards");
                }),
                buildProfileOption(
                  context,
                  context.tr('My Previous Orders'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPreviousOrdesScreen(),
                      ),
                    );
                    print("Checking Previous Orders");
                  },
                ),
                buildProfileOption(context, context.tr('Language'), () {
                  showLanguageDialog(context, (selectedLanguage) {
                    if (selectedLanguage == "ar") {
                      print("تم اختيار اللغة العربية");
                      // نفّذ أي أكشن خاص باللغة العربية هنا
                    } else if (selectedLanguage == "en") {
                      print("English language selected");
                      // نفّذ أي أكشن خاص باللغة الإنجليزية هنا
                    }
                  });
                  print("Changing Language");
                }),
                buildProfileOption(context, context.tr('Help'), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HalpScreen()),
                  );
                  print("Opening Help Section");
                }),
                buildProfileOption(context, context.tr('Call Us'), () {
                  _makePhoneCall(phoneNumber);
                  print("Calling Support");
                }),
                buildProfileOption(context, context.tr('Whatsapp'), () {
                  _openWhatsApp('+201099579130');
                  print("Opening Whatsapp");
                }),
                buildProfileOption(
                  context,
                  context.tr('Terms & Conditions'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsConditionsScreen(),
                      ),
                    );
                    print("Viewing Terms & Conditions");
                  },
                ),
                buildProfileOption(
                  context,
                  context.tr('Deactivate Account'),
                  () {
                    _showDeactivationDialog(context);
                    print("Deactivating Account");
                  },
                  isDanger: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileOption(
    BuildContext context,
    String title,
    VoidCallback onTap, {
    bool isDanger = false,
  }) {
    return GestureDetector(
      onTap: onTap, // تخصيص الحدث عند الضغط
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void showLanguageDialog(
    BuildContext context,
    Function(String) onLanguageSelected,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedLanguage = "";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Language",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() => selectedLanguage = "ar");
                        onLanguageSelected("ar");
                        if (context.locale.languageCode == 'en') {
                          LanguageService.changeLanguage(
                            context: context,
                            languageCode: 'ar',
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selectedLanguage == "ar"
                                  ? Colors.green
                                  : Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/ar.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.tr('Arabic'),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() => selectedLanguage = "en");
                        onLanguageSelected("en");
                        if (context.locale.languageCode == 'ar') {
                          LanguageService.changeLanguage(
                            context: context,
                            languageCode: 'en',
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selectedLanguage == "en"
                                  ? Colors.blue
                                  : Colors.white,
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/en.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.tr('English'),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    selectedLanguage == "en"
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  final String phoneNumber = "01099579130";

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // Future<void> callNow(String number) async {
  //   try {
  //     // تنظيف الرقم من أي مسافات أو أحرف غير مرغوبة
  //     final cleanNumber = number.replaceAll(RegExp(r'[^0-9+]'), '');

  //     await FlutterPhoneDirectCaller.callNumber(cleanNumber);
  //   } catch (e) {
  //     debugPrint('Error calling: $e');
  //     // يمكنك عرض SnackBar للمستخدم هنا
  //   }
  // }

  Future<void> _openWhatsApp(String phoneNumber) async {
    final Uri url = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('لا يمكن فتح WhatsApp');
    }
  }

  void _showDeactivationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr('Are you sure you want to deactivate your account?'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("تم إلغاء تفعيل الحساب");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    context.tr('Yes'),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("تم الإلغاء");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colorss.applicationColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    context.tr('No'),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
