import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';
import 'package:laundry_app/features/order_screen/presentation/views/widgets/schedule_order_body.dart';

class ScheduleOrder
 extends StatelessWidget {
  final String selectedImage;
  const ScheduleOrder
  ({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      appBar:CustomAppBar(titles: context.tr('Schedule an order'), color: Colorss.applicationColor  , backColor: Colors.black,) ,
      body: ScheduleOrderBody(selectedImage: selectedImage,),
    );
  }
}