import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:pilot/app/domain/usecases/get_cities_by_country_usecase.dart';
import 'package:pilot/app/domain/usecases/get_countries_usecase.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class LocationProvider extends ChangeNotifier {
  bool loading = false;
  String errorMessage = null;
  List<Country> countries = new List();
  List<City> currentCities = new List();
  Country selectedCountry;
  City selectedCity;
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
    }, (fetchedCities) {
      setCities(fetchedCities);
      setSelectedCity(fetchedCities.first);
      setLoading(false);
      setMessage(null);
      return fetchedCities;
    });
  }

  Future<bool> getCountries() async {
    setLoading(true);
    print('a-------------------------------');
    var result = await getCountriesUseCase(NoParams());
    return await result.fold((failure) {
      setLoading(false);
      print('went wrong');

      setMessage('something went wrong');
      return false;
    }, (fetchedCountries) async {
      setCountries(fetchedCountries);
      setSelectedCountry(countries.first);
      var cityResult = await getCitiesByCountryUseCase(
          GetCitiesByCountryParams(countryId: countries.first.id));
      cityResult.fold((failure) {
        setLoading(false);
        setMessage('something went wrong');
        return false;
      }, (fetchedCities) {
        setCities(fetchedCities);
        setSelectedCity(fetchedCities.first);
        setLoading(false);
        setMessage(null);
        return true;
      });
      setLoading(false);
      setMessage(null);
      return true;
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

  void setCountries(List<Country> fetchedCountries) {
    countries = fetchedCountries;
    notifyListeners();
  }

  void setSelectedCountry(newCountry) {
    selectedCountry = newCountry;
    notifyListeners();
  }

  void setSelectedCity(newCity) {
    selectedCity = newCity;
    print(selectedCity.name);

    notifyListeners();
  }

  void setCities(List<City> fetchedCities) {
    currentCities = fetchedCities;
    print(currentCities);
    notifyListeners();
  }
}
