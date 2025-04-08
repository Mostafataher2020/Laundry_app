import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/order_screen/presentation/order_cubit/schedule_order/order_cubit.dart';
import 'package:laundry_app/features/order_screen/presentation/order_cubit/schedule_order/order_state.dart';
import 'package:laundry_app/features/view_order_screen/presentation/views/track_order_screen.dart';

class OrderScreenBody extends StatelessWidget {
  final String selectedImage;
  

  const OrderScreenBody({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isArabic = context.locale.languageCode == 'ar';
    

    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is OrderSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final orderCubit = context.read<OrderCubit>();
        final orders = orderCubit.orders;

        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orders.isEmpty) {
          return Center(child: Text(context.tr('No orders found')));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF2F7),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('Order details'),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                _buildDetailRow(
                                  "${context.tr('Order ID')}:",
                                  "#${order["id"] ?? "N/A"}",
                                  Colors.orange,
                                ),
                                _buildDetailRow(
                                  "${context.tr('Picked up date')}:",
                                  _formatDate(order["pickupDate"]),
                                  Colors.orange,
                                ),
                                _buildDetailRow(
                                  "${context.tr('Time')}:",
                                  _formatTime(order["pickupTime"]),
                                  Colors.orange,
                                ),
                                _buildDetailRow(
                                  "${context.tr('Delivered date')}:",
                                  _formatDate(order["deliveryDate"]),
                                  Colors.orange,
                                ),
                                _buildDetailRow(
                                  "${context.tr('Time')}:",
                                  _formatTime(order["deliveryTime"]),
                                  Colors.orange,
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.03,
                            left:
                                isArabic
                                    ? 10
                                    : null, // إذا كانت العربية نستخدم left
                            right: isArabic ? null : 10,
                            child: Image.asset(
                              order["selectedImage"] ?? selectedImage,
                              width: screenWidth * 0.25, // زيادة حجم الصورة
                              height: screenHeight * 0.13, // زيادة حجم الصورة
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrackOrderScreen(),
                              ),
                            );

                            // إجراء عند الضغط على زر Track Order
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colorss.applicationColor, // لون الخلفية
                            foregroundColor: Colors.black, // لون النص
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            context.tr('Track Order'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            showCancelDialog(context, () {
                              orderCubit.removeOrder(order);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // لون الخلفية
                            foregroundColor: Colors.white, // لون النص
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            context.tr('Cancel'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  context.tr(
                    'You can cancel before the captain comes and\n picks up',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return "Not selected";
    return date; // مثال: "Sunday 11/4"
  }

  String _formatTime(String? time) {
    if (time == null) return "Not selected";
    return time; // مثال: "8 pm - 4 am"
  }

  void showCancelDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // ✅ زوايا دائرية
          ),
          backgroundColor: Colors.white.withOpacity(0.95), // ✅ لون فاتح للخلفية
          contentPadding: const EdgeInsets.all(20), // ✅ ضبط الحواف الداخلية
          content: Column(
            mainAxisSize: MainAxisSize.min, // ✅ يمنع تمدد الـ Dialog
            children: [
              Text(
                context.tr('Are you sure you want to cancel this order?'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onConfirm(); // ✅ استدعاء الفانكشن عند الضغط على "Yes"
                    Navigator.of(context).pop(); // ✅ إغلاق الـ Dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    context.tr('Yes'),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(); // ✅ إغلاق الـ Dialog عند الضغط على "No"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6FA7D8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(context.tr('No'), style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
