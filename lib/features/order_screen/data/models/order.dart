class Order {
  final int id;
  final String customerName;
  final DateTime orderDate;
  final OrderStatus status; // حالة الطلب (مثل: قيد الانتظار، تم الاستلام، تم التسليم)

  Order({
    required this.id,
    required this.customerName,
    required this.orderDate,
    required this.status,
  });
}

enum OrderStatus {
  pending, // قيد الانتظار
  received, // تم الاستلام
  delivered, // تم التسليم
  cancelled, // تم الإلغاء
}