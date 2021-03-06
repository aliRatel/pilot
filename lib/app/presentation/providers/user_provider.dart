import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/enums/app_action.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/usecases/check_for_available_users_usecase.dart';
import 'package:meta/meta.dart';
import 'package:pilot/core/usecases/usecase.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = true;
  dynamic user;
  String message;
  String userState; //fully registered or needs to complete profile
  JobSeeker jobSeeker;
  Company company;
  String token;
  UserType userType;
  AppAction neededAction= AppAction.signUp;
bool completed ;
//usecases
  final CheckForAvailableUsersUseCase checkForAvailableUsersUseCase;

  UserProvider({@required this.checkForAvailableUsersUseCase});

  Future<void> checkForUsers() async {

    var userResult = await checkForAvailableUsersUseCase(NoParams());
    userResult.fold((failure) {

      neededAction = AppAction.signUp;
    }, (userInfo) {
      mapUserInfoToAction(userInfo);
    });
  }

  void setLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  void setMessage(value) {
    message = value;
    notifyListeners();
  }

  void setUser(user) {
    this.user = user;
  }

  void setUserState(String s) {
    this.userState = s;
    notifyListeners();
  }

  void mapUserInfoToAction(Map<String, dynamic> userInfo) {
    userType = userInfo['userType'];
    token = userInfo['jwt'];
    user = userInfo['user'];
    completed = userInfo['completed'];
    userType == UserType.company ? company = user : jobSeeker = user;
    if (token != null) {
      if (company != null) {
        if (!completed) {
          neededAction = AppAction.CompleteCompanyInfo;
        } else {
          neededAction = AppAction.CompanyDashBoard;
        }
      } else if (jobSeeker != null) {
        if (!completed) {
          neededAction = AppAction.CompleteJobSeekerInfo;
        } else {
          neededAction = AppAction.JobSeekerDashBoard;
        }
      }
    } else {
      neededAction = AppAction.signUp;
    }
  }
}
