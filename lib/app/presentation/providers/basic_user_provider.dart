import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/enums/app_action.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job.dart';
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
  AppAction neededAction;

//usecases
  final CheckForAvailableUsersUseCase checkForAvailableUsersUseCase;

  UserProvider({@required this.checkForAvailableUsersUseCase});

  void checkForUsers() async {
    var userResult = await checkForAvailableUsersUseCase(NoParams());
    userResult.fold((failure) {
      neededAction = AppAction.signUp;
    }, (userInfo) {
      mapUserInfoToAction(userInfo);
    });
  }

  void setLoading(value) {
    isLoading = value;
    print('********************************' + value.toString());
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
    userType == UserType.company ? company = user : jobSeeker = user;
    if(token !=null){
      if(company !=null){

      }else if (Job){


    }else neededAction = AppAction.signUp;
  }
}
