import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';
import 'package:laundry_app/features/view_order_screen/presentation/views/widgets/track_order_screen_body.dart';

class TrackOrderScreen
 extends StatelessWidget {
  const TrackOrderScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      appBar: CustomAppBar(titles: context.tr('My Orders'), color: Colorss.applicationColor, backColor: Colors.black,),
      body: TrackOrderScreenBody()
    );
  }
}