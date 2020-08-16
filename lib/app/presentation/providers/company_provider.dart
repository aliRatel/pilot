import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/usecases/user_login_usecase.dart';

class CompanyProvider with ChangeNotifier{
  bool Loading = false;
  String errorMessage;

  final UserLoginUseCase userLoginUseCase ;


  CompanyProvider({@required this.userLoginUseCase});


  Future<bool> registerCompany({email,password,userType}) async {
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
    Loading = value;
    notifyListeners();
  }
  bool isLoading(){
    return Loading;
  }
}