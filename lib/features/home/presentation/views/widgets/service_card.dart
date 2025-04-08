import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';

class ServiceCard extends StatelessWidget {
  final String image;
  final VoidCallback buttonAction;
  final String title;
  ServiceCard({required this.image, required this.buttonAction, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: buttonAction, // استخدام buttonAction هنا
      child: Container(
        width: screenWidth * 0.9,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colorss.applicationColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 35,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF893D00),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              bottom: 10,
              child: Image.asset(
                image,
                width: 130,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
