import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
 final String label;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isError; // 🔹 متغير جديد للتحقق إذا كان الحقل فارغًا
  final double topMargin;
  final Function(String) onChanged;

  const BuildTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.onTap,
    required this.topMargin, required this.isError, required this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 64,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey, // ✅ يتغير اللون
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.blue, // ✅ اللون عند التركيز
                ),
              ),
            ),
            onTap: onTap,
            style: TextStyle(color: isError ? Colors.red : Colors.black), // ✅ لون النص عند الخطأ
          ),
        ),
      ],
    );
  }
}
