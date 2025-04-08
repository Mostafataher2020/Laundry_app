import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:laundry_app/core/error/failures.dart';

class OrderRepository {
  final Dio dio;

  OrderRepository(this.dio);

  Future<Either<Failure, int>> fetchOrderStatus() async {
    try {
      // Mock data بدل API
      await Future.delayed(Duration(seconds: 2)); // Mock delay
      return Right(3); // Mock order status
    } catch (e) {
      return Left(NetworkFailure());
    }
  }
}