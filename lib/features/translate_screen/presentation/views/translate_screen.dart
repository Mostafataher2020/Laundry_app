import 'package:flutter/material.dart';
import 'package:laundry_app/features/translate_screen/presentation/views/widgets/translate_screen_body.dart';

class TranslateScreen
 extends StatelessWidget {
  const TranslateScreen
  ({super.key});

  @override
/*************  ✨ Codeium Command ⭐  *************/
/// Builds the widget tree for the TranslateScreen.
/// 
/// This method returns a [Scaffold] widget containing the
/// [TranslateScreenBody] as its body.
/// 
/// [context] is the BuildContext in which the widget is built.

/******  1948c7a3-13af-4aeb-9ebc-095eb3467ed0  *******/
  Widget build(BuildContext context) {
    return Scaffold(
      body: TranslateScreenBody(),
    );
  }
}