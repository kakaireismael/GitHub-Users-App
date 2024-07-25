// core/error/failures.dart
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class Equatable {
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
