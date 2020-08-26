import 'package:flutter/material.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/usecases/get_jobs_by_company_usecase.dart';

class CompanyDashBoardProvider extends ChangeNotifier{
  bool loading = false;
  bool initLoad = true;
  String errorMessage;
  int pageNumber = 1;
  int totalPages = 1;
  var jobs = [];

final GetJobsByCompanyUseCase getJobsByCompanyUseCase;


  CompanyDashBoardProvider({@required this.getJobsByCompanyUseCase});

  Future<void> getJobs() async {
    if (pageNumber > totalPages) return null;
    setLoading(true);
    var result = await getJobsByCompanyUseCase(
        GetJobsByCompanyParams(pageNumber: pageNumber));
    print(result);
    result.fold((failure) {
      setLoading(false);
      setInitLoad(false);
    }, (jobs) {
      increasePageNumber();
      //totalPages = resultMap['totalPages'];
      var newJobs = jobs;

      addFetchedJobs(newJobs);
      setLoading(false);
      setInitLoad(false);
    });
    setInitLoad(false);

  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void increasePageNumber() {
    pageNumber++;
    notifyListeners();
  }

  void setMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  void setInitLoad(bool value) {
    initLoad = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isLoading() {
    return loading;
  }

  bool isInitLoading() {
    return initLoad;
  }

  void addFetchedJobs(List<Job> data) {
    if (jobs.length > 0 && jobs.last == null)
      jobs.removeLast();

    jobs = jobs + data;
    if (pageNumber < totalPages)
      jobs.add(null);
    notifyListeners();
    print(jobs);
  }

}