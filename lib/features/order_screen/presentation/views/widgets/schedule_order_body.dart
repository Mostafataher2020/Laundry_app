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
  final String selectedImage;

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

  String get serviceType {
    if (widget.selectedImage.contains('clothe')) return 'clothes';
    if (widget.selectedImage.contains('balnk')) return 'blanket';
    if (widget.selectedImage.contains('carp')) return 'carpet';
    return 'clothes';
  }

  // Time slots generation methods
  String _formatTimeSlot(int startHour, int endHour) {
    String formatHour(int hour) {
      if (hour == 0) return '12 ${context.tr('AM')}';
      if (hour < 12) return '$hour ${context.tr('AM')}';
      if (hour == 12) return '12 ${context.tr('PM')}';
      return '${hour - 12} ${context.tr('PM')}';
    }

    return '${formatHour(startHour)} - ${formatHour(endHour)}';
  }

  List<String> get pickupTimeSlots {
    List<String> allSlots = [];
    for (int i = 11; i <= 21; i += 2) {
      if (i + 2 <= 24) {
        allSlots.add(_formatTimeSlot(i, i + 2));
      }
    }
    return allSlots;
  }

  List<String> get deliveryTimeSlots {
    List<String> allSlots = [];
    for (int i = 11; i <= 21; i += 2) {
      if (i + 2 <= 24) {
        allSlots.add(_formatTimeSlot(i, i + 2));
      }
    }
    return allSlots;
  }

  List<Map<String, String>> get pickupDates {
    final now = DateTime.now();
    final dates = <Map<String, String>>[];
    
    for (int i = 0; i < 3; i++) {
      final date = now.add(Duration(days: i));
      dates.add({
        'date': '${date.day}/${date.month}',
        'day': _getDayName(date.weekday),
        'fullDay': _getFullDayName(date), // إضافة اسم اليوم الكامل
      });
    }
    
    return dates;
  }

  List<Map<String, String>> get deliveryDates {
    final now = DateTime.now();
    final dates = <Map<String, String>>[];
    int daysToAdd = 1;
    
    if (serviceType == 'blanket') daysToAdd = 3;
    if (serviceType == 'carpet') daysToAdd = 6;
    
    for (int i = daysToAdd; i < daysToAdd + 3; i++) {
      final date = now.add(Duration(days: i));
      dates.add({
        'date': '${date.day}/${date.month}',
        'day': _getDayName(date.weekday),
        'fullDay': _getFullDayName(date), // إضافة اسم اليوم الكامل
      });
    }
    
    return dates;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return context.tr('Mon');
      case 2: return context.tr('Tue');
      case 3: return context.tr('Wed');
      case 4: return context.tr('Thu');
      case 5: return context.tr('Fri');
      case 6: return context.tr('Sat');
      case 7: return context.tr('Sun');
      default: return '';
    }
  }

  String _getFullDayName(DateTime date) {
    // دالة جديدة لإرجاع اسم اليوم كاملاً
    switch (date.weekday) {
      case 1: return context.tr('Monday');
      case 2: return context.tr('Tuesday');
      case 3: return context.tr('Wednesday');
      case 4: return context.tr('Thursday');
      case 5: return context.tr('Friday');
      case 6: return context.tr('Saturday');
      case 7: return context.tr('Sunday');
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();

    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PriceListScreen()),
          ).then((_) => orderCubit.resetSelection());
        } else if (state is OrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Your Location Section
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

                // Price List Button
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

                // Pickup Date & Time Section
                Text(
                  context.tr('Select Pickup Date & Time'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: pickupDates.map((date) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: BuildSelectableBox(
                          title: '${date['fullDay']}\n${date['date']}', // استخدام fullDay بدلاً من day
                          isSelected: orderCubit.selectedPickupDate == date['date'],
                          onTap: () => orderCubit.setPickupDate(date['date']!),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pickupTimeSlots.map((time) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: BuildSelectableBox(
                          title: time,
                          isSelected: orderCubit.selectedPickupTime == time,
                          onTap: () => orderCubit.setPickupTime(time),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),

                // Delivery Date & Time Section
                Text(
                  context.tr('Select Delivery Date & Time'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: deliveryDates.map((date) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: BuildSelectableBoxBlue(
                          title: '${date['fullDay']}\n${date['date']}', // استخدام fullDay بدلاً من day
                          isSelected: orderCubit.selectedDeliveryDate == date['date'],
                          onTap: () => orderCubit.setDeliveryDate(date['date']!),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: deliveryTimeSlots.map((time) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: BuildSelectableBoxBlue(
                          title: time,
                          isSelected: orderCubit.selectedDeliveryTime == time,
                          onTap: () => orderCubit.setDeliveryTime(time),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 40),

                // Order Details Section
                Column(
                  children: [
                    Text(context.tr('Are you sure you want to cancel this order?'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
                        SizedBox(height: 25),
                    Text(context.tr('By clicking proceed, you agree to Terms of Use'),style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),),
                  ]
                ),
                SizedBox(height: 20),

                // Proceed Button
                if (state is OrderLoading)
                  CircularProgressIndicator()
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
                            selectedImage: widget.selectedImage,
                          );
                        }
                      },
                      color: Color(0xFFC09471),
                      width: MediaQuery.of(context).size.width * 0.8,
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