import 'package:flutter/material.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/usecases/AddNewJobUseCase.dart';

class AddJobProvider extends ChangeNotifier {
  bool loading = false;
  String errorMessage;

  final AddNewJobUseCase addNewJobUseCase;


  AddJobProvider({@required this.addNewJobUseCase});

  Future<bool> addJob(String title, String skills, int countryId, int cityId,
      String abstract, String description,) async {
    setLoading(true);
    Job job =Job(title: title,abstract: abstract,description: description,skills: skills,countryId: countryId,cityId: cityId);
    var result = await addNewJobUseCase(AddNewJobParams(job: job));
    return result.fold((failure) {
      print('wentWrong');
      setMessage('something went wrong');
      setLoading(false);
      return false;
    }, (success){
      setMessage(null);
      setLoading(false);
      print('success');

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
}