import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';

class SaveCardScreen
 extends StatelessWidget {
  const SaveCardScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      appBar: CustomAppBar(titles: context.tr('Saved Cards'), color: Colorss.applicationColor, backColor: Colors.black,),
    );
  }
}