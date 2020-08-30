import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/presentation/pages/job_companies_dashboard/job_companies_dashboard.dart';
import 'package:pilot/app/presentation/providers/complete_company_registration_provider.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/widgets/my_drop_down_button.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import 'package:provider/provider.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/country.dart' as COU;

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
  final FocusNode _companyNameFocus = FocusNode();
  final FocusNode _countryRegionFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  TextEditingController _zipController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  COU.Country _selectedCountry;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _selectedCountry =
          Provider.of<LocationProvider>(this.context, listen: false)
              .countries
              .last;
    });

    super.initState();
  }

  void _submit(LocationProvider locationProvider) {
    //if (!_formKey.currentState.validate()) return;

    String companyName = _companyNameController.text.trim();
    String zipCode = _zipController.text.trim();
    String street = _streetController.text.trim();
    String mobileNumber ='+'+ _mobileController.text.trim();
    String phoneNumber = '+'+_phoneController.text.trim();
    int buildingNumber = int.parse(_buildingNumberController.text.trim());
    int cityId = locationProvider.selectedCity
        .id;
    int countryId = locationProvider.selectedCountry
        .id;

    Provider.of<CompleteCompanyRegistrationProvider>(context, listen: false)
        .completeProfile(
            companyName: companyName,
            cityId: cityId,
            countryId: countryId,
            zipCode: zipCode,
            street: street,
            mobileNumber: mobileNumber,
            phoneNumber: phoneNumber,
            buildingNumber: buildingNumber)
        .then((value) {
      if (value) {
        print(value);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => JobCompaniesDashboard(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
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
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _companyNameController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (input) => fieldFocusChange(
                  context,
                  _companyNameFocus,
                  _countryRegionFocus,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _companyNameFocus,
                hint: 'Company Name',
                title: 'Company name',
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                ),
                child: Align(
                  child: Text('Country/Region'),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              MyDropDownButton(
                items: locationProvider.countries,
                initialValue: locationProvider.selectedCountry,
                valueChanged: (dynamic newCountry) async {
                  print(newCountry.name);
                  locationProvider.setSelectedCountry(newCountry);
                  print('==================================');
                  print(_selectedCountry.name);
                  await locationProvider
                      .getCities(locationProvider.selectedCountry.id);

                  setState(() {
                    fieldFocusChange(
                      context,
                      _countryRegionFocus,
                      _cityFocus,
                    );
                  });
                },
              ),
              SizedBox(height: ScreenUtil().setHeight(28)),
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
              locationProvider
                      .isLoading()
                  ? CircularProgressIndicator()
                  : MyDropDownButton(
                      items: Provider.of<LocationProvider>(context)
                          .currentCities,
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
              SizedBox(height: ScreenUtil().setHeight(28)),
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
              SizedBox(height: ScreenUtil().setHeight(10)),
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
              SizedBox(height: ScreenUtil().setHeight(10)),
              MyTextFormField(
                validator: (value) => validateRequiredTextField(value),
                controller: _buildingNumberController,
                keyboardType: TextInputType.number,
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
              SizedBox(height: ScreenUtil().setHeight(10)),
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
              SizedBox(height: ScreenUtil().setHeight(10)),
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
              Padding(
                padding: EdgeInsets.all(12.0),
                child: myButton(
                  context: context,
                  child: Provider.of<CompleteCompanyRegistrationProvider>(
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
                  onTap: !Provider.of<CompleteCompanyRegistrationProvider>(
                              context,
                              listen: false)
                          .isLoading()
                      ? () {
                          _submit(locationProvider);
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

//  void validateAndRegister() {
//    if (_formKey.currentState.validate()) {}
//  }
}
