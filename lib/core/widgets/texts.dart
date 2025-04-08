import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;
  final TextStyle? styles;
  final TextAlign? textAlign;
  
  const Texts({
    required this.text,
    required this.color,
    super.key,
    this.fontSize, this.styles, this.textAlign,
  
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
      style: TextStyle(
        
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
