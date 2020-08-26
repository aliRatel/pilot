import 'package:flutter/material.dart';
import 'package:pilot/app/domain/usecases/get_jobs_by_company_usecase.dart';

class CompanyDashBoardProvider extends ChangeNotifier{
  bool loading = false;
  String errorMessage;

final GetJobsByCompanyUseCase getJobsByCompanyUseCase;


  CompanyDashBoardProvider({@required this.getJobsByCompanyUseCase});

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