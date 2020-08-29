import 'package:flutter/widgets.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/usecases/complete_company_profile_usecase.dart';
import 'package:pilot/app/domain/usecases/complete_user_profile_usecase.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';

class CompleteJobSeekerRegistrationProvider extends ChangeNotifier {
  bool loading = false;
  String errorMessage;

  final CompleteJobSeekerProfileUseCase completeJobSeekerProfileUseCase;

  CompleteJobSeekerRegistrationProvider(
      {@required this.completeJobSeekerProfileUseCase});

  Future<bool> completeProfile(
      {name,
      surname,
      nationality,
      countryId,
      cityId,
      zipCode,
      street,
      houseNumber,
      phoneNumber,
      mobileNumber,
      cv,
      personalPhoto,
      coverLetter,
      birthday}) async {
    setLoading(true);
    JobSeeker jobSeeker = JobSeeker(
        name: name,
        surname: surname,
        nationality: nationality,
        country: countryId,
        city: cityId,
        zipCode: zipCode,
        street: street,
        houseNumber: 1,
        phoneNumber: phoneNumber,
        gender: 'M',
        mobileNumber: '64546',
        coverLetter: coverLetter,
        birthday: birthday);

    var result = await completeJobSeekerProfileUseCase(
        CompleteJobSeekerProfileParams(
            jobSeeker: jobSeeker, cv: cv, personalPhoto: personalPhoto));
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
