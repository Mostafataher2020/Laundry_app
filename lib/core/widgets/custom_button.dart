import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
   final Color color;
   final  VoidCallback buttonAction; // متغير يتحكم في الزر
  

   CustomButton({super.key, required this.text,required this.buttonAction, required this.color, required double width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => buttonAction(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // التدوير الناعم
          ),
          // padding: EdgeInsets.symmetric(vertical: 16), // التحكم في الارتفاع
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black, // لون النص
          ),
        ),
      ),
    );
  }
}
