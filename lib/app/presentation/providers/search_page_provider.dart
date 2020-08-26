import 'package:flutter/material.dart';
import 'package:pilot/app/domain/usecases/search_jobs_usecase.dart';

class SearchPageProvider extends ChangeNotifier{
  bool loading = false;
  String errorMessage;

final SearchJobsUseCase searchJobsUseCase;


  SearchPageProvider({@required this.searchJobsUseCase});

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