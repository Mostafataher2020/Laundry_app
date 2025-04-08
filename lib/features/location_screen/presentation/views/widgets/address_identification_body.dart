import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/arrow_back.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/core/widgets/texts.dart';
import 'package:laundry_app/features/home/presentation/views/home_screen.dart';

class AddressIdentificationBody extends StatefulWidget {
  const AddressIdentificationBody({super.key});

  @override
  State<AddressIdentificationBody> createState() =>
      _AddressIdentificationBodyState();
}

class _AddressIdentificationBodyState extends State<AddressIdentificationBody> {
  bool isVilla = false;

  final TextEditingController buildingController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController villaController = TextEditingController();
  final TextEditingController lockCodeController = TextEditingController();
  final TextEditingController guardMobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: isPortrait ? screenHeight : null,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFEAD7), Color(0xFFFFEAD7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: ArrowBack(
                    onTap: () => Navigator.pop(context),
                    colors: Colors.black,
                  ),
                ),
                Center(
                  child: Texts(
                    text: context.tr('Choose your location from the app'),
                    color: Colors.black,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Center(
                  child: Container(
                    width: screenWidth * 0.85,
                    height: isPortrait ? screenHeight * 0.37 : screenHeight * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/location.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleOption("${context.tr('Apartment')}/${context.tr('Architecture')}", !isVilla, () {
                      setState(() => isVilla = false);
                    }),
                    const SizedBox(width: 10),
                    Text("/", style: TextStyle(fontSize: 18, color: Colors.grey)),
                    const SizedBox(width: 10),
                    _buildToggleOption(context.tr('Villa'), isVilla, () {
                      setState(() => isVilla = true);
                    }),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isVilla)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                              context.tr('Building No'), 
                              buildingController, 
                              isPortrait ? screenWidth * 0.42 : screenWidth * 0.25
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            _buildTextField(
                              context.tr('Floor No'), 
                              floorController, 
                              isPortrait ? screenWidth * 0.42 : screenWidth * 0.25
                            ),
                          ],
                        ),
                      if (isVilla)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildTextField(
                            context.tr('Villa Number'), 
                            villaController,
                            isPortrait ? screenWidth * 0.4 : screenWidth * 0.3
                          ),
                        ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                            context.tr('Recipients mobile number'), 
                            apartmentController, 
                            isPortrait ? screenWidth * 0.42 : screenWidth * 0.25
                          ),
                          // SizedBox(width: screenWidth * 0.05),
                          // _buildTextField(
                          //   context.tr('Building Lock Code'), 
                          //   lockCodeController, 
                          //   isPortrait ? screenWidth * 0.42 : screenWidth * 0.25
                          // ),
                        ],
                      ),
                      // SizedBox(height: 10),
                      // _buildTextField(
                      //   context.tr('Security Guard Mobile'), 
                      //   guardMobileController, 
                      //   isPortrait ? screenWidth * 0.7 : screenWidth * 0.5
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isPortrait ? 20 : screenWidth * 0.2,
                  ),
                  child: CustomButton(
                    text:context.tr('Done'),
                    buttonAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }, 
                    color: Color(0xFFC09471), width: screenWidth * 0.8,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.black : Colors.grey,
          decoration: isSelected ? TextDecoration.underline : null,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, double width) {
    return SizedBox(
      width: width,
      height: 45,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54, fontSize: 14),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ),
    );
  }
}