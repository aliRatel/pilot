import 'package:flutter/material.dart';
import 'package:pilot/app/domain/usecases/AddNewJobUseCase.dart';

class AddJobProvider extends ChangeNotifier{
  bool loading = false;
  String errorMessage;

final AddNewJobUseCase addNewJobUseCase;


  AddJobProvider({@required this.addNewJobUseCase});

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