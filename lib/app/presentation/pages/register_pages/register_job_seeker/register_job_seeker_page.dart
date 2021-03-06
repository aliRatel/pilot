import 'dart:io';
import 'dart:ui';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/country.dart' as COU;
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/job_seeker_dashboard.dart';
import 'package:pilot/app/presentation/providers/complete_JobSeeker_registration_provider.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/widgets/my_drop_down_button.dart';
import 'package:provider/provider.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import '../../../../../core/util/consts.dart';
import '../../../widgets/gender_type.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/text_form_field.dart';

class RegisterJobSeekerPage extends StatefulWidget {
  @override
  _RegisterJobSeekerPageState createState() => _RegisterJobSeekerPageState();
}

class _RegisterJobSeekerPageState extends State<RegisterJobSeekerPage> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _zipFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _houseNumberFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _surnameFocus = FocusNode();
  final FocusNode _countryRegionFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
final FocusNode _coverLetterFocus = FocusNode();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _houseNumberController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _coverLetterController = TextEditingController();
  UserGender _userGender = UserGender.M;
  final format = DateFormat("yyyy-MM-dd");

  File _userImage;
  File _cvFile;


  DateTime _birthday = DateTime(1995,1,1);

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      //_selectedCountry =
          Provider.of<LocationProvider>(this.context, listen: false)
              .countries
              .last;
    });

    super.initState();
  }

  void _submit() {
     if (!_formKey.currentState.validate()) return;


    String name = _surnameController.text.trim();
    String surname = _surnameController.text.trim();
    String zipCode = _zipController.text.trim();
    String street = _streetController.text.trim();
    String mobileNumber = '+'+_mobileController.text.trim();
    String phoneNumber = '+'+_phoneController.text.trim();
    String houseNumber = _houseNumberController.text.trim();
     String coverLetter = _coverLetterController.text.trim();
    int cityId = Provider.of<LocationProvider>(this.context, listen: false)
        .selectedCity
        .id;
    int countryId = Provider.of<LocationProvider>(this.context, listen: false)
        .selectedCountry
        .id;
String nationality = Provider.of<LocationProvider>(this.context, listen: false)
    .selectedCountry
    .name;
    Provider.of<CompleteJobSeekerRegistrationProvider>(
      this.context,
      listen: false,
    )
        .completeProfile(
            name: name,
            surname: surname,
            gender:_userGender.toShortString(),
            cityId: cityId,
            countryId: countryId,
            nationality: nationality,
            zipCode: zipCode,
            street: street,
            mobileNumber: mobileNumber,
            phoneNumber: phoneNumber,
            houseNumber: houseNumber,
            birthday: _birthday,
            cv: _userImage,
            personalPhoto: _cvFile,
    coverLetter: coverLetter)
        .then((value) {
      if (value) {
        Navigator.pushReplacement(
            this.context,
            MaterialPageRoute(
              builder: (context) => JobSeekerDashboard(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(230),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        image: DecorationImage(
                          image: _userImage == null
                              ? AssetImage(
                                  'assets/images/account_placeholder.jpg',
                                )
                              : FileImage(
                                  _userImage,
                                ),
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: _userImage == null
                          ? AssetImage(
                              'assets/images/account_placeholder.jpg',
                            )
                          : FileImage(
                              _userImage,
                            ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width / 4,
                      top: MediaQuery.of(context).size.height / 10.5,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () async {
                              var a = await FilePicker.getFile(
                                allowCompression: true,
                                type: FileType.image,
                              );
                              print(a.path);
                              setState(() {
                                _userImage = a;
                              });
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        'My Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      top: ScreenUtil().setHeight(20),
                    ),
                    Positioned(
                      child: Text(
                        '${_surnameController.text}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      bottom: ScreenUtil().setHeight(25),
                    ),
                    Positioned(
                      child: Text(
                        '${_nameController.text}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      bottom: ScreenUtil().setHeight(5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              MyTextFormField(
                hint: 'ex : jack',
                controller: _nameController,
                title: 'Name',
                onTextChange: (String input) {
                  setState(() {});
                },
                validator: (value) => validateRequiredTextField(value),
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _nameFocus,
                  _surnameFocus,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _nameFocus,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              MyTextFormField(
                onTextChange: (String input) {
                  setState(() {});
                },
                hint: 'ex: Max',
                controller: _surnameController,
                title: 'Sur name',
                validator: (value) => validateRequiredTextField(value),
                onFieldSubmitted: (input) =>
                    fieldFocusChange(context, _surnameFocus, null),
                textInputAction: TextInputAction.done,
                focusNode: _surnameFocus,
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              getGenderRadioButtons(
                (selected) => setState(
                  () => _userGender = selected,
                ),
                _userGender,
              ),
              SizedBox(height: ScreenUtil().setHeight(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                ),
                child: DateTimeField(
                  validator: (DateTime input) {
                    if (input == null || input.toString().isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: (BorderRadius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: mainColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: (BorderRadius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: mainColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: (BorderRadius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: mainColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: (BorderRadius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: mainColor,
                      ),
                    ),
                    hintText: '1995-1-1',
                    labelText: 'birthday 1995-1-1',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  onChanged: (DateTime dt) {
                    _birthday = dt;
                  },
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(18)),
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _phoneController,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _phoneFocus,
                  _mobileFocus,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _phoneFocus,
                hint: 'Phone Number',
                keyboardType: TextInputType.phone,
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+1',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                title: 'Phone Number',
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _mobileController,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _mobileFocus,
                  null,
                ),
                textInputAction: TextInputAction.done,
                focusNode: _mobileFocus,
                keyboardType: TextInputType.phone,
                hint: 'Mobile Number',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CountryPickerDropdown(
                    initialValue: 'EG',
                    itemBuilder: _buildDropdownItem,
                    priorityList: [
                      CountryPickerUtils.getCountryByIsoCode('GB'),
                      CountryPickerUtils.getCountryByIsoCode('CN'),
                    ],
                    sortComparator: (Country a, Country b) =>
                        a.isoCode.compareTo(b.isoCode),
                    onValuePicked: (Country country) {
                      print("${country.name}");
                    },
                  ),
                ),
                title: 'Mobile Number',
                //leadingIcon: Icons.mob,
              ),
              SizedBox(height: ScreenUtil().setHeight(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Upload your cv',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Expanded(
                      child: myButton(
                        onTap: () async {
                          File file = await FilePicker.getFile();
                          _cvFile = file;
                          setState(() {});
                        },
                        child: Icon(
                          FontAwesomeIcons.upload,
                          color: Colors.white,
                        ),
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  _cvFile == null ? '' : basename(_cvFile.path),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                ),
                child: Align(
                  child: Text('Country/Region'),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              MyDropDownButton(
                items: locationProvider.countries,
                initialValue: locationProvider.selectedCountry,
                valueChanged: (dynamic newCountry) async {
                  locationProvider.setSelectedCountry(newCountry);
                  await locationProvider
                      .getCities(locationProvider.selectedCountry.id);

                  fieldFocusChange(
                    context,
                    _countryRegionFocus,
                    _cityFocus,
                  );
                },
              ),
              SizedBox(height: ScreenUtil().setHeight(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                ),
                child: Align(
                  child: Text('City'),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              locationProvider.isLoading()
                  ? CircularProgressIndicator()
                  : MyDropDownButton(
                      items:
                          Provider.of<LocationProvider>(context).currentCities,
                      initialValue:
                          Provider.of<LocationProvider>(context).selectedCity,
                      valueChanged: (dynamic newCity) {
                        Provider.of<LocationProvider>(context, listen: false)
                            .setSelectedCity(newCity);
                        fieldFocusChange(
                          context,
                          _cityFocus,
                          _zipFocus,
                        );
                      },
                    ),
              SizedBox(height: ScreenUtil().setHeight(26)),
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _zipController,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _zipFocus,
                  _streetFocus,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _zipFocus,
                hint: 'ZIP Code',
                title: 'ZIP Code',
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _streetController,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _streetFocus,
                  _houseNumberFocus,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                focusNode: _streetFocus,
                hint: 'Street',
                title: 'Street',
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _houseNumberController,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _houseNumberFocus,
                  _coverLetterFocus,
                ),
                textInputAction: TextInputAction.done,
                focusNode: _houseNumberFocus,
                hint: 'House Number',
                title: 'House Number',
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              MyTextFormField(maxLines: 5,
                validator: (value) => validateRequiredTextField(value),
                controller: _coverLetterController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _coverLetterFocus,
                  null,
                ),
                textInputAction: TextInputAction.done,
                focusNode: _coverLetterFocus,
                hint: 'Cover Letter',
                title: 'Cover Letter',
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: myButton(
                  context: context,
                  child: Provider.of<CompleteJobSeekerRegistrationProvider>(
                              context)
                          .loading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  onTap: !Provider.of<CompleteJobSeekerRegistrationProvider>(
                              context,
                              listen: false)
                          .isLoading()
                      ? () {
                          _submit();
                        }
                      : null,
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );

  void validateAndRegisterCompany() {
    if (_formKey.currentState.validate()) {
      if (_cvFile == null) {
        // handle this point
      }
      if (_userImage == null) {
        // handle this point
      }
    }
  }
}
