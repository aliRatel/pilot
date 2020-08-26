import 'package:flutter/material.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/usecases/get_recent_jobs_usecase.dart';

class JobSeekerDashBoardProvider extends ChangeNotifier {
  bool loading = false;
  bool initLoad = true;
  String errorMessage;
  int pageNumber = 1;
  int totalPages = 1;
  var jobs = [];
//  var fixtures = [
//    Job(
//        id: 1,
//        companyName: 'google',
//        title: 'developer1',
//        description:
//        'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained'),
//    Job(
//        id: 1,
//        companyName: 'google',
//        title: 'developer1',
//        description:
//        'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained'),
//  ];
  final GetRecentJobsUseCase getRecentJobsUseCase;

  JobSeekerDashBoardProvider({@required this.getRecentJobsUseCase});

  Future<void> getJobs() async {
    if (pageNumber > totalPages) return null;
    setLoading(true);
    var result = await getRecentJobsUseCase(
        GetRecentJobsParams(pageNumber: pageNumber));
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
  }

}
