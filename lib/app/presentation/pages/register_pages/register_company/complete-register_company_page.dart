import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'file:///D:/bebo_flutter/pilot/lib/presentation/widgets/text_form_field.dart';
import 'package:pilot/presentation/widgets/my_button.dart';
import 'package:pilot/utils/consts.dart';

class CompleteRegisterCompany extends StatefulWidget {
  @override
  _CompleteRegisterCompanyState createState() =>
      _CompleteRegisterCompanyState();
}

class _CompleteRegisterCompanyState extends State<CompleteRegisterCompany> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(130),
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
                  hint: 'Company Name',
                  title: 'Company Name',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  hint: 'United States',
                  title: 'Country/Region',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  hint: 'City',
                  title: 'City',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  hint: 'ZIP Code',
                  title: 'ZIP Code',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  hint: 'Street',
                  title: 'Street',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  hint: 'Building Number',
                  title: 'Building Number',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
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
                      context: context, title: 'Continue', onTap: () {}),
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
}
