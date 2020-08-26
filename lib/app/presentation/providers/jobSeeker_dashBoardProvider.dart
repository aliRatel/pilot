import 'package:flutter/material.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/usecases/get_recent_jobs_usecase.dart';

class JobSeekerDashBoardProvider extends ChangeNotifier {
  bool loading = false;
  String errorMessage;

  final GetRecentJobsUseCase getRecentJobsUseCase;

  JobSeekerDashBoardProvider({@required this.getRecentJobsUseCase});

  Future<List<Job>> getJobs(int pageNumber) async {
//var result = await getRecentJobsUseCase(GetRecentJobsParams(pageNumber:pageNumber));
    return [
      Job(
          id: 1,
          companyName: 'google',
          title: 'developer1',
          description: 'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained'),
      Job(
          id: 1,
          companyName: 'google',
          title: 'developer2',
          description: 'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained'),
      Job(
          id: 1,
          companyName: 'google',
          title: 'developer3',
          description: 'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained'),
      Job(
          id: 1,
          companyName: 'google',
          title: 'developer4',
          description: 'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained')
    ];
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
