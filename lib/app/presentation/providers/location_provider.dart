import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:pilot/app/domain/usecases/get_cities_by_country_usecase.dart';
import 'package:pilot/app/domain/usecases/get_countries_usecase.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class LocationProvider extends ChangeNotifier {
  bool loading = false;
  String errorMessage;
List<Country> countries;
List<City> currentCities;
  final GetCountriesUseCase getCountriesUseCase;

  final GetCitiesByCountryUseCase getCitiesByCountryUseCase;

  LocationProvider(
      {@required this.getCountriesUseCase,
      @required this.getCitiesByCountryUseCase});

  Future<List<City>> getCities(int countryId) async {
    setLoading(true);
    var result = await getCitiesByCountryUseCase(
        GetCitiesByCountryParams(countryId: countryId));
    return await result.fold((failure) {
      setLoading(false);
      setMessage('something went wrong');
      return null;
    }, (cities) {
      setLoading(false);
      setMessage(null);
      return cities;
    });
  }

  Future<List<Country>> getCountries() async {
    setLoading(true);
    var result = await getCountriesUseCase(NoParams());
     return await result.fold((failure) {
      setLoading(false);
      setMessage('something went wrong');
      return null;
    }, (countries) {
      setLoading(false);
      setMessage(null);
      return  countries;
    });
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isLoading() {
    return loading;
  }
}
