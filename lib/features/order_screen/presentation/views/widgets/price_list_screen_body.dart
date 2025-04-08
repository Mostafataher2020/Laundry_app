import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';

class PriceListScreenBody extends StatefulWidget {
  const PriceListScreenBody({Key? key}) : super(key: key);

  @override
  State<PriceListScreenBody> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreenBody> {
  String selectedCategory = "Wash & Iron";

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<Map<String, String>> getCurrentList() {
    switch (selectedCategory) {
      case "Wash & Iron":
        return washAndIronItems;
      case "Iron":
        return ironItems;
      case "Dry Clean":
        return dryCleanItems;
      default:
        return washAndIronItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(18.0),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            color: Colorss.applicationColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              categoryButton(context.tr('Wash & Iron')),
              categoryButton(context.tr('lron')),
              categoryButton(context.tr('Dry Clean')),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              // color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.builder(
              itemCount: getCurrentList().length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colorss.applicationColor : Color.fromARGB(255, 227, 183, 118),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getCurrentList()[index]["name"]!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        context.tr('1.00 SR'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget categoryButton(String category) {
    return Expanded(
      child: GestureDetector(
        onTap: () => updateCategory(category),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color:
                selectedCategory == category
                    ? const Color.fromARGB(255, 227, 183, 118)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> washAndIronItems = [
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
];

List<Map<String, String>> ironItems = [
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
];

List<Map<String, String>> dryCleanItems = [
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
  {"name": 'Taqia'.tr()},
];
