import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/arrow_back.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/core/widgets/texts.dart';
import 'package:laundry_app/features/location_screen/presentation/views/address_identification.dart';

class LocationScreenBody extends StatelessWidget {
  const LocationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFEAD7), Color(0xFFFFEAD7)], // لون متدرج احترافي
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 زر الرجوع
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.03),
                child: ArrowBack(
                  onTap: () => Navigator.pop(context),
                  colors: Colors.black,
                  size: screenWidth * 0.07,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Texts(
                  text: context.tr('Choose your location from the app'),
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                  textAlign: TextAlign.center,
                  styles: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: Colors.blue, width: 3),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/location.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                text: context.tr('Next'),
                buttonAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressIdentification(),
                    ),
                  );
                }, color: Color(0xFFC09471), width: screenWidth * 0.4,
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
