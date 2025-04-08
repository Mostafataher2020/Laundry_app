import 'package:flutter/material.dart';
import 'package:laundry_app/features/location_screen/presentation/views/widgets/location_screen_body.dart';

class LocationScreen
 extends StatelessWidget {
  const LocationScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LocationScreenBody(),
    );
  }
}