import 'package:flutter/cupertino.dart';
import 'package:pilot/app/domain/usecases/user_signup_useCase.dart';

class SignUpProvider with ChangeNotifier{
  bool loading = false;
  String errorMessage;

  final UserSignUpUseCase userSignUpUseCase ;


  SignUpProvider({@required this.userSignUpUseCase});


  Future<bool> signUpUser({email,password,userType}) async {
    setLoading(true);
    var result =await userSignUpUseCase(UserSignUpParams(email:email  ,password: password,userType:userType));
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