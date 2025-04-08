import 'package:flutter/material.dart';

class BuildSelectableBox extends StatelessWidget {
  const BuildSelectableBox({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap, 
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF2C6A1) : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
