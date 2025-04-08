import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';
import 'package:laundry_app/features/order_screen/presentation/views/widgets/price_list_screen_body.dart';

class PriceListScreen
 extends StatelessWidget {
  const PriceListScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      appBar: CustomAppBar(titles: context.tr('Price list'), color: Colorss.applicationColor, backColor: Colors.black,),
      body: PriceListScreenBody(),
    );
  }
}