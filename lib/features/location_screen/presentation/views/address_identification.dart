import 'package:flutter/material.dart';
import 'package:laundry_app/features/location_screen/presentation/views/widgets/address_identification_body.dart';

class AddressIdentification
 extends StatelessWidget {
  const AddressIdentification
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddressIdentificationBody(),
    );
  }
}