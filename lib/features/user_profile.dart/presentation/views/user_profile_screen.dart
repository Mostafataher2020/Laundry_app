import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_app_bar.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/widgets/user_profile_screen_body.dart';

class UserProfileScreen
 extends StatelessWidget {
  const UserProfileScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colorss.applicationColor,
      appBar: CustomAppBar(titles: context.tr('User Profile'), color: Colors.white, backColor: Colors.white,),
      body: UserProfileScreenBody(),
    );
  }
}