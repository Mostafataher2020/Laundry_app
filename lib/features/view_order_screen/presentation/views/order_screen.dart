import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';
import 'package:laundry_app/features/view_order_screen/presentation/views/widgets/order_screen_body.dart';

class OrderScreen extends StatelessWidget {
  final String selectedImage;
  const OrderScreen({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      appBar: CustomAppBar(titles: context.tr('My Orders'), color: Colorss.applicationColor, backColor: Colors.black,),
      body: OrderScreenBody(selectedImage: selectedImage,),);
  }
}
