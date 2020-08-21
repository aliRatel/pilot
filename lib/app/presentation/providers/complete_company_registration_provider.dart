import 'package:flutter/widgets.dart';
import 'package:pilot/app/domain/usecases/complete_company_profile_usecase.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';

class CompleteCompanyRegistrationProvider extends ChangeNotifier {
  bool loading = false;
  String errorMessage;

  final CompleteCompanyProfileUseCase completeCompanyProfileUseCase;

  CompleteCompanyRegistrationProvider(
      {@required this.completeCompanyProfileUseCase});

  void completeProfile(
      {companyName,
      countryId,
      cityId,
      zipCode,
      street,
      buildingNumber,
      phoneNumber,
      mobileNumber}) async {
    setLoading(true);
    var result = await completeCompanyProfileUseCase(
        CompleteCompanyProfileParams(
            companyName: companyName,
            countryId: countryId,
            cityId: cityId,
            zipCode: zipCode,
            street: street,
            buildingNumber: buildingNumber,
            phoneNumber: phoneNumber,
            mobileNumber: mobileNumber));
    return await result.fold((failure) {
      setMessage('something went wrong');
      setLoading(false);
      return false;
    }, (success) {
      setLoading(false);
      setMessage('');
      return true;
    });
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }
}
