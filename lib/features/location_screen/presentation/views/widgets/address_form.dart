// import 'package:flutter/material.dart';

// class AddressForm extends StatefulWidget {
//   @override
//   _AddressFormState createState() => _AddressFormState();
// }

// class _AddressFormState extends State<AddressForm> {
//   bool isVilla = false; // التبديل بين Apartment و Villa

//   // Controllers لحفظ القيم المدخلة
//   final TextEditingController buildingController = TextEditingController();
//   final TextEditingController floorController = TextEditingController();
//   final TextEditingController apartmentController = TextEditingController();
//   final TextEditingController villaController = TextEditingController();
//   final TextEditingController lockCodeController = TextEditingController();
//   final TextEditingController guardMobileController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// 🔹 التبديل بين Apartment و Villa
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildToggleOption("Apartment/compound", !isVilla, () {
//               setState(() => isVilla = false);
//             }),
//             const SizedBox(width: 10),
//             Text("/", style: TextStyle(fontSize: 18, color: Colors.grey)),
//             const SizedBox(width: 10),
//             _buildToggleOption("Villa", isVilla, () {
//               setState(() => isVilla = true);
//             }),
//           ],
//         ),

//         SizedBox(height: 12),

//         /// 🔹 إدخال البيانات
//         Wrap(
//           spacing: screenWidth * 0.03,
//           runSpacing: 10,
//           alignment: WrapAlignment.center,
//           children: [
//             if (!isVilla) _buildTextField("Building No.", buildingController, screenWidth),
//             if (!isVilla) _buildTextField("Floor No.", floorController, screenWidth),
//             if (isVilla) _buildTextField("Villa No.", villaController, screenWidth),
//             _buildTextField("Apartment No.", apartmentController, screenWidth),
//             _buildTextField("Building Lock Code", lockCodeController, screenWidth),
//             _buildTextField("Security Guard Mobile", guardMobileController, screenWidth, fullWidth: true),
//           ],
//         ),
//       ],
//     );
//   }

//   /// 🔹 تصميم خيار التبديل بين Apartment و Villa
//   Widget _buildToggleOption(String label, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           color: isSelected ? Colors.black : Colors.grey,
//           decoration: isSelected ? TextDecoration.underline : null,
//         ),
//       ),
//     );
//   }

//   /// 🔹 تصميم حقل الإدخال
//   Widget _buildTextField(String label, TextEditingController controller, double screenWidth, {bool fullWidth = false}) {
//     return SizedBox(
//       width: fullWidth ? screenWidth * 0.85 : screenWidth * 0.4,
//       height: 45,
//       child: TextField(
//         controller: controller,
//         style: TextStyle(fontSize: 14),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white.withOpacity(0.2),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//           ),
//           labelText: label,
//           labelStyle: TextStyle(color: Colors.black54, fontSize: 14),
//           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         ),
//       ),
//     );
//   }
// }
