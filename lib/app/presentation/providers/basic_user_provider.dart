import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/user.dart';
import 'package:pilot/app/domain/usecases/check_for_available_users_usecase.dart';
import 'package:meta/meta.dart';
import 'package:pilot/core/usecases/usecase.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = true;
  String message;
  int userType;
  dynamic user;

  String userState;  //fully registered or needs to complete profile
  User jobSeeker;
  Company company;
  String token;

//usecases
  final CheckForAvailableUsersUseCase checkForAvailableUsersUseCase;

  UserProvider({@required this.checkForAvailableUsersUseCase});


  void checkForUsers() async {
    //setLoading(true);

//    var userResult = await checkForAvailableUsersUseCase(NoParams());
//    userResult.fold((failure) {
//      setMessage(failure.message);
//    }, (user) {
//      setUser(user);
//      if (user is User)
//        userType = 1;
//      else if (user is Company) userType = 0;
//    });
//
//    if(user != null){
//  //  var     tokenResult = await getTokenUseCase(NoParams());
//    }
    userState='hasUser';
    //setUserState('hasUser');
   // setLoading(false);

  }

  void setLoading(value) {
    isLoading = value;
    print('********************************'+value.toString());
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
}
