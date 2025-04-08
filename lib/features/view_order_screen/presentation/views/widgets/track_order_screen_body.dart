import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundry_app/core/apis/order_repository.dart';
import 'package:laundry_app/core/widgets/custom_button.dart';
import 'package:laundry_app/features/payment/presentation/views/payment_screen.dart';
import 'package:laundry_app/features/view_order_screen/presentation/managers/orders_cubit/order_cubits.dart';
import 'package:laundry_app/features/view_order_screen/presentation/managers/orders_cubit/order_states.dart';

class TrackOrderScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => OrderCubits(OrderRepository(Dio()))..getOrderStatus(),
      child: BlocBuilder<OrderCubits, OrderStates>(
        builder: (context, state) {
          if (state is OrderLoadings) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderErrors) {
            return Center(child: Text(state.failure.message));
          } else if (state is OrderLoadeds) {
            return OrderStatusWidget(
              orderStatus: state.status,
              selectedIndexes:
                  state.selectedIndexes, // تمرير selectedIndexes من الـ state
            );
          }
          return Container();
        },
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  final int orderStatus;
  final List<int> selectedIndexes; // List لحفظ العناصر المختارة

  OrderStatusWidget({required this.orderStatus, required this.selectedIndexes});

  final List<Map<String, dynamic>> steps = [
    {
      'title': 'Captain on the way'.tr(),
      'subtitle':
          'Prepare your order for pick up, the captain will pick up your order at the time you selected'.tr(),
      'icon': FontAwesomeIcons.truckMoving,
      'status': 1,
    },
    {
      'title': 'Your order has been picked'.tr(),
      'subtitle':
          'Your order is on the way to laundry and we will be sending your bill soon'.tr(),
      'icon': FontAwesomeIcons.truckFast,
      'status': 2,
    },
    {
      'title': 'Waiting for payment'.tr(),
      'subtitle':
          'The laundry started washing. Make the payment now to prepare your order for delivery'.tr(),
      'icon': FontAwesomeIcons.moneyBillWave,
      'status': 3, // حالة الدفع
    },
    {
      'title': 'Your order is ready to be delivered'.tr(),
      'subtitle':
          'The captain will deliver your order at the time you selected'.tr(),
      'icon': FontAwesomeIcons.box,
      'status': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // تحقق إذا كان العنصر المختار هو حالة الدفع
    bool isPaymentSelected = selectedIndexes.contains(
      2,
    ); // 2 هو index حالة الدفع

    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: ListView.builder(
            itemCount: steps.length,
            itemBuilder: (context, idx) {
              var step = steps[idx];
              bool isSelected = selectedIndexes.contains(
                idx,
              ); // تحقق إذا كان العنصر مختار

              return GestureDetector(
                onTap: () {
                  context.read<OrderCubits>().toggleStepSelection(idx);
                },
                child: Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.025,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.10,
                        backgroundColor:
                            isSelected
                                ? Color.fromARGB(255, 227, 183, 118)
                                : Color(0xFFD9D9D9), // لون الأيقونة بيتغير
                        child: FaIcon(
                          step['icon'],
                          size: screenWidth * 0.09,
                          color:
                              isSelected
                                  ? Colors.white
                                  : Colors.black, // لون الأيقونة بيتغير
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              step['subtitle']!,
                              style: TextStyle(fontSize: screenWidth * 0.03),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // إظهار الـ Container الإضافي في أسفل الشاشة فقط إذا كان العنصر المختار هو حالة الدفع
        if (isPaymentSelected)
          Positioned(
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.12,
            right: screenWidth * 0.12,
            child: GestureDetector(
              onTap: () {
              
              },
              child: CustomButton(text: context.tr('View your bill'), buttonAction: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(),),
                );
              }, color: Color(0xFFC09471), width: screenWidth,),
            ),
          ),
      ],
    );
  }
}
