import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/home/presentation/views/widgets/service_card.dart';
import 'package:laundry_app/features/order_screen/presentation/views/schedule_order.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Image
          Container(
            width: screenWidth,
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/home.png'),
              ),
            ),
          ),

          // Services Section
          Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colorss.applicationColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
            child: Column(
              children: [
                Text(
                  context.tr('Our Services'),
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),

                // Services List
                ServiceCard(
                  image: 'assets/images/clothe.png',
                  buttonAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleOrder(
                          selectedImage: 'assets/images/clothe.png', // تمرير الصورة المحددة
                        ),
                      ),
                    );
                  }, title: context.tr('Clothes wash'),
                ),
                SizedBox(height: 15),
                ServiceCard(
                  image: 'assets/images/carp.png',
                  buttonAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleOrder(
                          selectedImage: 'assets/images/carp.png', // تمرير الصورة المحددة
                        ),
                      ),
                    );
                  }, title: context.tr('Carpet wash'),
                ),
                SizedBox(height: 15),
                ServiceCard(
                  image: 'assets/images/balnk.png',
                  buttonAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleOrder(
                          selectedImage: 'assets/images/balnk.png', // تمرير الصورة المحددة
                        ),
                      ),
                    );
                  }, title: context.tr('Blanket wash'),
              )],),),  
      ],
            ),
          
        
      
    );
  }
}