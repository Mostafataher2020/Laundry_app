import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/arrow_back.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titles;
  final Color color;
  final Color backColor;

  const CustomAppBar({super.key, required this.titles, required this.color, required this.backColor});
  @override
  Size get preferredSize => Size.fromHeight(70); // ارتفاع الـ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: ArrowBack(onTap: () {
        Navigator.pop(context);
      },colors: backColor,),
      centerTitle: true,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          titles,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
