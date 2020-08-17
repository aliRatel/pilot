import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

 class Failure extends Equatable {

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
class UnknownFailure extends Failure{}