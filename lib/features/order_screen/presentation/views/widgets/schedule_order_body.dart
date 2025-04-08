import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/features/order_screen/presentation/order_cubit/schedule_order/order_cubit.dart';
import 'package:laundry_app/features/order_screen/presentation/order_cubit/schedule_order/order_state.dart';
import 'package:laundry_app/features/order_screen/presentation/views/price_list_screen.dart';
import 'package:laundry_app/features/order_screen/presentation/views/widgets/build_selectable_box.dart';
import 'package:laundry_app/features/order_screen/presentation/views/widgets/build_selectable_box_blue.dart';

class ScheduleOrderBody extends StatefulWidget {
  final String selectedImage; // الصورة المحددة

  const ScheduleOrderBody({super.key, required this.selectedImage});

  @override
  State<ScheduleOrderBody> createState() => _ScheduleOrderBodyState();
}

class _ScheduleOrderBodyState extends State<ScheduleOrderBody> {
  String? selectedPickupDate;
  String? selectedPickupTime;
  String? selectedDeliveryDate;
  String? selectedDeliveryTime;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    resetSelection();
    Future.delayed(Duration.zero, () {
      final data =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
      if (data != null) {
        setState(() {
          selectedPickupDate = data["pickupDate"];
          selectedPickupTime = data["pickupTime"];
          selectedDeliveryDate = data["deliveryDate"];
          selectedDeliveryTime = data["deliveryTime"];
        });
      }
    });
  }

  void resetSelection() {
    setState(() {
      selectedPickupDate = null;
      selectedPickupTime = null;
      selectedDeliveryDate = null;
      selectedDeliveryTime = null;
      isSelected = true; // إعادة اللون الافتراضي
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();

    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PriceListScreen()),
          ).then((_) => orderCubit.resetSelection());
        } else if (state is OrderFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // عرض الصورة المحددة
                // Container(
                //   width: double.infinity,
                //   height: 150,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     image: DecorationImage(
                //       image: AssetImage(widget.selectedImage),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),

                // 📍 تفاصيل الموقع
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.tr('Your Location'),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/location.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // 📍 زر قائمة الأسعار (Price List)
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colorss.applicationColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PriceListScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      context.tr('Price list'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // 📍 اختيار موعد الاستلام
                Text(
                  context.tr('Select Pickup Date & Time'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BuildSelectableBox(
                        title: context.tr('Saturday\n12/12'),
                        isSelected: orderCubit.selectedPickupDate == "12/12",
                        onTap: () => orderCubit.setPickupDate("12/12"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: BuildSelectableBox(
                        title: context.tr('Sunday\n13/12'),
                        isSelected: orderCubit.selectedPickupDate == "13/12",
                        onTap: () => orderCubit.setPickupDate("13/12"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: BuildSelectableBox(
                        title: context.tr('Monday\n14/12'),
                        isSelected: orderCubit.selectedPickupDate == "14/12",
                        onTap: () => orderCubit.setPickupDate("14/12"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // 📍 تمرير أفقي لاختيار وقت الاستلام
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildSelectableBox(
                        title: context.tr('11 am : 3 pm'),
                        isSelected: orderCubit.selectedPickupTime == "11-3",
                        onTap: () => orderCubit.setPickupTime("11-3"),
                      ),
                      SizedBox(width: 10),
                      BuildSelectableBox(
                        title: context.tr('4 pm : 7 pm'),
                        isSelected: orderCubit.selectedPickupTime == "4-7",
                        onTap: () => orderCubit.setPickupTime("4-7"),
                      ),
                      SizedBox(width: 10),
                      BuildSelectableBox(
                        title: context.tr('8 pm : 10 pm'),
                        isSelected: orderCubit.selectedPickupTime == "8-10",
                        onTap: () => orderCubit.setPickupTime("8-10"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // 📍 اختيار موعد التوصيل
                Text(
                  context.tr('Select Delivery Date & Time'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BuildSelectableBoxBlue(
                        title: context.tr('Sunday\n13/12'),
                        isSelected: orderCubit.selectedDeliveryDate == "13/12",
                        onTap: () => orderCubit.setDeliveryDate("13/12"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: BuildSelectableBoxBlue(
                        title: context.tr('Monday\n14/12'),
                        isSelected: orderCubit.selectedDeliveryDate == "14/12",
                        onTap: () => orderCubit.setDeliveryDate("14/12"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: BuildSelectableBoxBlue(
                        title: "Tuesday\n15/12",
                        isSelected: orderCubit.selectedDeliveryDate == "15/12",
                        onTap: () => orderCubit.setDeliveryDate("15/12"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // 📍 تمرير أفقي لاختيار وقت التوصيل
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildSelectableBoxBlue(
                        title: context.tr('11 am : 3 pm'),
                        isSelected: orderCubit.selectedDeliveryTime == "11-3",
                        onTap: () => orderCubit.setDeliveryTime("11-3"),
                      ),
                      SizedBox(width: 10),
                      BuildSelectableBoxBlue(
                        title: context.tr('4 pm : 7 pm'),
                        isSelected: orderCubit.selectedDeliveryTime == "4-7",
                        onTap: () => orderCubit.setDeliveryTime("4-7"),
                      ),
                      SizedBox(width: 10),
                      BuildSelectableBoxBlue(
                        title: context.tr('8 pm : 10 pm'),
                        isSelected: orderCubit.selectedDeliveryTime == "8-10",
                        onTap: () => orderCubit.setDeliveryTime("8-10"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // 📍 تفاصيل الطلب
                if (selectedPickupDate != null && selectedPickupTime != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('Order details'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${context.tr('Picked up date')}: $selectedPickupDate",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${context.tr('Time')}: $selectedPickupTime",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${context.tr('Delivered date')}: $selectedDeliveryDate",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${context.tr('Time')}: $selectedDeliveryTime",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        context.tr('You can cancel before the captain comes'),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                SizedBox(height: 20),

                // 📍 تأكيد الطلب
                Text(
                  context.tr('Are you sure to place order?'),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  context.tr('By clicking proceed, you agree to Terms of Use'),
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),

                // 📍 زر تنفيذ الطلب
                if (state is OrderLoading)
                  CircularProgressIndicator() // عرض مؤشر التحميل
                else
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.050,
                    child: CustomButton(
                      text: context.tr('Proceed the order'),
                      buttonAction: () {
                        if (orderCubit.selectedPickupDate == null ||
                            orderCubit.selectedPickupTime == null ||
                            orderCubit.selectedDeliveryDate == null ||
                            orderCubit.selectedDeliveryTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.tr('Please select all required fields.'),
                              ),
                            ),
                          );
                        } else {
                          orderCubit.submitOrder(
                            selectedImage:
                                widget.selectedImage, // تمرير الصورة المحددة
                          );
                        }
                      }, color: Color(0xFFC09471), width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    context.tr('Cancel'),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
