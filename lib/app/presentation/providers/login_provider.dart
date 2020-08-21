import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/usecases/user_login_usecase.dart';

class LogInProvider with ChangeNotifier{
  bool loading = false;
  String errorMessage;

  final UserLoginUseCase userLoginUseCase ;


  LogInProvider({@required this.userLoginUseCase});


  Future<bool> loginUser({email,password,userType}) async {
    setLoading(true);
    var result =await userLoginUseCase(UserLoginParams(email:email  ,password: password,userType:userType));
    return await result.fold((failure) {
      setMessage('something went wrong');
      setLoading(false);
      return false;
    }, (user) {
      setLoading(false);
      setMessage('');
      return true;
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