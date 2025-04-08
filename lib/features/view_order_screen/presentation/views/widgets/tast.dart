// Container(
//       width: screenWidth,
//       height: screenHeight,
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
//       child: ListView.builder(
//         itemCount: steps.length,
//         itemBuilder: (context, idx) {
//           var step = steps[idx];
//           bool isSelected = selectedIndexes.contains(idx);

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (isSelected) {
//                   selectedIndexes.remove(idx); // إلغاء التحديد
//                 } else {
//                   selectedIndexes.add(idx); // تحديد العنصر
//                 }
//               });
//             },
//             child: Container(
//               width: screenWidth * 0.9,
//               margin: EdgeInsets.only(bottom: screenHeight * 0.02),
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.05,
//                 vertical: screenHeight * 0.025,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: screenWidth * 0.10,
//                     backgroundColor: isSelected ? Color(0xFF084059) : Color(0xFF9EC3DE),
//                     child: FaIcon(
//                       step['icon'],
//                       size: screenWidth * 0.09,
//                       color: isSelected ? Colors.white : Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.05),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           step['title']!,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: screenWidth * 0.04,
//                             color: Colors.blue.shade900,
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.005),
//                         Text(
//                           step['subtitle']!,
//                           style: TextStyle(fontSize: screenWidth * 0.03),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );