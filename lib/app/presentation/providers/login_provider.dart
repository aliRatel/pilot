import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/usecases/user_login_usecase.dart';

class LogInProvider with ChangeNotifier{
  bool loading = false;
  String errorMessage;

  final UserLoginUseCase userLoginUseCase ;

  LogInProvider({@required this.userLoginUseCase});


  Future<UserType> loginUser({email,password}) async {
    setLoading(true);
    var result =await userLoginUseCase(UserLoginParams(email:email  ,password: password));
    return await result.fold((failure) {
      setMessage('something went wrong');
      setLoading(false);
      print('went wrong');

      return null;
    }, (user) {

      print(user);
      setLoading(false);
      setMessage(null);
      return user;
    });


  }

  void setMessage(value){
    errorMessage = value;
    notifyListeners();
  }
  void setLoading(value){
    loading = value;
    notifyListeners();
  }
  bool isLoading(){
    return loading;
  }
}