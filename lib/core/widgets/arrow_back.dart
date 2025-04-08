import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  final VoidCallback onTap;
  final Color colors;
  final double? size;
  const ArrowBack({super.key, required this.onTap, required this.colors, this.size});

  @override
/*************  ✨ Codeium Command ⭐  *************/
/// Builds an IconButton widget that represents a back arrow.
/// 
/// The button triggers the provided [onTap] callback when pressed and displays
/// an icon of a left-pointing arrow with a black color.

/******  e92c8f92-e83b-4e53-8373-66fea4369bfe  *******/
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: Icon(Icons.arrow_back_ios,color:colors),);
    // Icon(Icons.arrow_back_ios, color: Colors.black);
  }
}
