import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:pilot/core/error/failures.dart';
abstract class UtilitiesRepository {

  Future<Either<Failure,List<Country>>> getCountries();
  Future<Either<Failure,List<Country>>> getCountryById({int id});


}