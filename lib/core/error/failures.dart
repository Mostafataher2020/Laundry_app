abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super("Server error occurred.");
}

class NetworkFailure extends Failure {
  NetworkFailure() : super("Please check your internet connection.");
}