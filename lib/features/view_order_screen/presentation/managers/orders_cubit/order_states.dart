import 'package:equatable/equatable.dart';
import 'package:laundry_app/core/error/failures.dart';

abstract class OrderStates extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitials extends OrderStates {}

class OrderLoadings extends OrderStates {}

class OrderLoadeds extends OrderStates {
  final int status;
  final List<int> selectedIndexes; // List لحفظ العناصر المختارة

  OrderLoadeds(this.status, {this.selectedIndexes = const []});

  // copyWith method علشان ننشئ نسخة جديدة من الـ state
  OrderLoadeds copyWith({
    int? status,
    List<int>? selectedIndexes,
  }) {
    return OrderLoadeds(
      status ?? this.status,
      selectedIndexes: selectedIndexes ?? this.selectedIndexes,
    );
  }

  @override
  List<Object> get props => [status, selectedIndexes];
}

class OrderErrors extends OrderStates {
  final Failure failure;
  OrderErrors(this.failure);

  @override
  List<Object> get props => [failure];
}