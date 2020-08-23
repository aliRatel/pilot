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
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/job_seeker_dashboard.dart';
import 'package:pilot/app/presentation/providers/complete_JobSeeker_registration_provider.dart';
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
  final FocusNode _buildingNumberFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  TextEditingController _zipController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  UserGender _userGender = UserGender.male;

  File _userImage;
  File _cvFile;
  List<String> countries = [];
  List<String> cities = [];
  String selectedCountry = '';
  String selectedCity = '';
  DateTime birthday;

  @override
  void initState() {
    super.initState();

    countries = countries_cities.keys.toList();
    cities = countries_cities[countries_cities.keys.first];

    selectedCountry = countries[0];
    selectedCity = cities[0];
  }

  void _submit() {
    if (!_formKey.currentState.validate()) return;

    print(_userImage.path);
    print('asdfajsdlkfjasdl;kgjasdl;kgjals;kdgjlsak;djglak;sdjglak;sdjgl;asddjgl;asdjg');


    String name = _nameController.text.trim();
    String zipCode = _zipController.text.trim();
    String street = _streetController.text.trim();
    String mobileNumber = _mobileController.text.trim();
    String phoneNumber = _phoneController.text.trim();
    String buildingNumber = _buildingNumberController.text.trim();
    int cityId = cities.indexOf(selectedCity); //TODO increase by 1
    int countryId = selectedCountry.indexOf(selectedCountry); //TODO increase by 1

    Provider.of<CompleteJobSeekerRegistrationProvider>(this.context, listen: false)
        .completeProfile(
            name: name,
            surname: 'asfdasdfa',
            cityId: cityId,
            countryId: countryId,
            nationality: "sssssss",
            zipCode: zipCode,
            street: street,
            mobileNumber: mobileNumber,
            phoneNumber: phoneNumber,
            houseNumber: buildingNumber,
            birthday: birthday,
            cv: _userImage,
            personalPhoto: _userImage)
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
    final format = DateFormat("yyyy-MM-dd");
    return SafeArea(
      child: Scaffold(
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
                                  _userImage=a;
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
                          '${_nameController.text}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        bottom: ScreenUtil().setHeight(25),
                      ),
                      Positioned(
                        child: Text(
                          '${_emailController.text}',
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
                  hint: 'user@example.com',
                  controller: _emailController,
                  title: 'Email',
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  validator: (value) => validateRequiredTextField(value),
                  onFieldSubmitted: (input) => fieldFocusChange(
                    context,
                    _emailFocus,
                    _nameFocus,
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: ScreenUtil().setHeight(8)),
                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  hint: 'ex: Max',
                  controller: _nameController,
                  title: 'Sur name',
                  validator: (value) => validateRequiredTextField(value),
                  onFieldSubmitted: (input) =>
                      fieldFocusChange(context, _nameFocus, null),
                  textInputAction: TextInputAction.done,
                  focusNode: _nameFocus,
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
                      hintText: 'ex: 27-5-1998',
                      labelText: 'Birth of date',
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
                    onChanged: (DateTime dt){
                      birthday = dt;
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                  ),
                  child: Container(
                    height: ScreenUtil().setHeight(55),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(12),
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: mainColor,
                        width: 1,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectedCountry,
                        hint: Text("Select a country"),
                        items: countries
                            .map(
                              (country) => DropdownMenuItem<String>(
                                child: Text('$country'),
                                value: country,
                              ),
                            )
                            .toList(),
                        onChanged: (newCountry) {
                          setState(() {
                            selectedCountry = newCountry;
                          });

                          cities = countries_cities[newCountry];
                          selectedCity = cities[0];
                        },
                      ),
                    ),
                  ),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                  ),
                  child: Container(
                    height: ScreenUtil().setHeight(55),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(12),
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: mainColor,
                        width: 1,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectedCity,
                        hint: Text("Select a city"),
                        items: cities
                            .map(
                              (city) => DropdownMenuItem<String>(
                                child: Text('$city'),
                                value: city,
                              ),
                            )
                            .toList(),
                        onChanged: (newCity) {
                          setState(() {
                            selectedCity = newCity;
                          });
                        },
                      ),
                    ),
                  ),
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
                    _buildingNumberFocus,
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
                  controller: _buildingNumberController,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (input) => fieldFocusChange(
                    context,
                    _buildingNumberFocus,
                    null,
                  ),
                  textInputAction: TextInputAction.done,
                  focusNode: _buildingNumberFocus,
                  hint: 'Building Number',
                  title: 'Building Number',
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
