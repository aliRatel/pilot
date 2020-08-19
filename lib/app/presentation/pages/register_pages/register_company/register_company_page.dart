import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';

import '../../../../../core/util/consts.dart';
import '../../../widgets/base_clipper.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/text_form_field.dart';

class RegisterCompanyPage extends StatefulWidget {
  @override
  _RegisterCompanyPageState createState() => _RegisterCompanyPageState();
}

class _RegisterCompanyPageState extends State<RegisterCompanyPage> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _zipFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _buildingNumberFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();

  TextEditingController _zipController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  List<String> countries = [];
  List<String> cities = [];

  String selectedCountry = '';
  String selectedCity = '';

  @override
  void initState() {
    super.initState();

    countries = countries_cities.keys.toList();
    cities = countries_cities[countries_cities.keys.first];

    selectedCountry = countries[0];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ClipPath(
                  clipper: BaseCLipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(150),
                    decoration: BoxDecoration(color: mainColor),
                    child: Center(
                      child: Text(
                        'Complete company create an account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  'Please complete the creating account process',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
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
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
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
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
                  controller: _streetController,
                  onFieldSubmitted: (input) => fieldFocusChange(
                    context,
                    _streetFocus,
                    _buildingNumberFocus,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                  focusNode: _streetFocus,
                  hint: 'Street',
                  title: 'Street',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
                  controller: _buildingNumberController,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (input) => fieldFocusChange(
                    context,
                    _buildingNumberFocus,
                    _phoneFocus,
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _buildingNumberFocus,
                  hint: 'Building Number',
                  title: 'Building Number',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
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
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
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
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: myButton(
                    context: context,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: validateAndRegister,
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

  void validateAndRegister() {
    if (_formKey.currentState.validate()) {}
  }
}
