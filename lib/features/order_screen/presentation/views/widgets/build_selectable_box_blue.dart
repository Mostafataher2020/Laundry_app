import 'package:flutter/material.dart';

class BuildSelectableBoxBlue extends StatelessWidget {
  const BuildSelectableBoxBlue({
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
          color: isSelected ? Color(0xFF084059) : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
