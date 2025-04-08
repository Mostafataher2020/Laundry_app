import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:laundry_app/core/apis/order_repository.dart';
import 'package:laundry_app/core/error/failures.dart';
import 'order_states.dart';

class OrderCubits extends Cubit<OrderStates> {
  final OrderRepository orderRepository;

  OrderCubits(this.orderRepository) : super(OrderInitials());

  void getOrderStatus() async {
    emit(OrderLoadings());

    final Either<Failure, int> result = await orderRepository.fetchOrderStatus();

    result.fold(
      (failure) => emit(OrderErrors(failure)),
      (status) => emit(OrderLoadeds(status)),
    );
  }

void toggleStepSelection(int stepIndex) {
  if (state is OrderLoadeds) {
    final currentState = state as OrderLoadeds;
    final selectedIndexes = List<int>.from(currentState.selectedIndexes);

    if (selectedIndexes.contains(stepIndex)) {
      selectedIndexes.remove(stepIndex); // إلغاء التحديد
    } else {
      selectedIndexes.add(stepIndex); // تحديد العنصر
    }

    // استخدام copyWith علشان ننشئ state جديدة
    emit(currentState.copyWith(selectedIndexes: selectedIndexes));
  }
}
}