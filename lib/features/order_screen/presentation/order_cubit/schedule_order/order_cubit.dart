import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/apis/order_repository.dart';
import 'package:laundry_app/features/order_screen/presentation/order_cubit/schedule_order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  String? selectedPickupDate;
  String? selectedPickupTime;
  String? selectedDeliveryDate;
  String? selectedDeliveryTime;

  List<Map<String, dynamic>> orders = []; // تغيير List<Map<String, String>> إلى List<Map<String, dynamic>>

  void setPickupDate(String date) {
    selectedPickupDate = date;
    emit(OrderInitial());
  }

  void setPickupTime(String time) {
    selectedPickupTime = time;
    emit(OrderInitial());
  }

  void setDeliveryDate(String date) {
    selectedDeliveryDate = date;
    emit(OrderInitial());
  }

  void setDeliveryTime(String time) {
    selectedDeliveryTime = time;
    emit(OrderInitial());
  }

  void resetSelection() {
    selectedPickupDate = null;
    selectedPickupTime = null;
    selectedDeliveryDate = null;
    selectedDeliveryTime = null;
    emit(OrderInitial());
  }

  // دالة لإضافة طلب جديد إلى القائمة
  void addOrder(Map<String, dynamic> newOrder) {
    orders.add(newOrder); // إضافة الطلب الجديد
    emit(OrderUpdated()); // إشعار الواجهة بالتحديث
  }

  // دالة لمسح قائمة الطلبات
  void clearOrders() {
    orders.clear(); // مسح القائمة
    emit(OrderUpdated()); // إشعار الواجهة بالتحديث
  }

  void removeOrder(Map<String, dynamic> order) {
    orders.remove(order); // حذف الطلب من القائمة
    emit(OrderUpdated()); // إشعار الواجهة بالتحديث
  }

  // دالة لمحاكاة إرسال الطلب
  Future<void> submitOrder({required String selectedImage}) async {
    // تحقق من وجود البيانات المطلوبة
    if (selectedPickupDate == null ||
        selectedPickupTime == null ||
        selectedDeliveryDate == null ||
        selectedDeliveryTime == null) {
      emit(OrderFailure("Please select all required fields.")); // حالة الفشل
      return; // إيقاف التنفيذ إذا كانت البيانات غير مكتملة
    }

    emit(OrderLoading()); // حالة التحميل

    try {
      // محاكاة استدعاء API باستخدام Future.delayed
      await Future.delayed(Duration(seconds: 2));

      // إنشاء طلب جديد مع الصورة المحددة
      final newOrder = {
        "id": "${orders.length + 1}", // إنشاء ID فريد
        "pickupDate": selectedPickupDate!,
        "pickupTime": selectedPickupTime!,
        "deliveryDate": selectedDeliveryDate!,
        "deliveryTime": selectedDeliveryTime!,
        "selectedImage": selectedImage, // إضافة الصورة المحددة
      };

      addOrder(newOrder); // إضافة الطلب الجديد إلى القائمة

      // إذا نجح الطلب
      emit(OrderSuccess("Order submitted successfully!"));
    } catch (e) {
      // إذا فشل الطلب
      emit(OrderFailure("Failed to submit order: ${e.toString()}"));
    }
  }

  getOrderStatus() {}
}