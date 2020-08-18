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
import 'package:pilot/app/presentation/providers/gender_radio_button.dart';
import 'package:provider/provider.dart';

import '../../../../../core/util/consts.dart';
import '../../../widgets/gender_type.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/text_form_field.dart';

class RegisterJobSeekerPage extends StatefulWidget {
  @override
  _RegisterJobSeekerPageState createState() => _RegisterJobSeekerPageState();
}

class _RegisterJobSeekerPageState extends State<RegisterJobSeekerPage> {
  final formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  File userImage;
  File cvFile;
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
    final bloc = Provider.of<GenderRadioProvider>(context);
    final format = DateFormat("yyyy-MM-dd");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                            image: userImage == null
                                ? AssetImage(
                                    'assets/images/account_placeholder.jpg',
                                  )
                                : FileImage(
                                    userImage,
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
                        backgroundImage: userImage == null
                            ? AssetImage(
                                'assets/images/account_placeholder.jpg',
                              )
                            : FileImage(
                                userImage,
                              ),
                      ),
                      Positioned(
                        right: MediaQuery.of(context).size.width / 4.5,
                        top: MediaQuery.of(context).size.height / 10.5,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                userImage = await FilePicker.getFile(
                                  allowCompression: true,
                                  type: FileType.image,
                                );
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: Icon(Icons.edit),
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
                          '$name',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        bottom: ScreenUtil().setHeight(25),
                      ),
                      Positioned(
                        child: Text(
                          '$email',
                          style: TextStyle(color: Colors.black),
                        ),
                        bottom: ScreenUtil().setHeight(5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                MyTextFormField(
                  hint: 'user@example.com',
                  onTextChange: (String input) {
                    email = input;
                    setState(() {});
                  },
                  title: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                MyTextFormField(
                  hint: 'ex: Max',
                  onTextChange: (String input) {
                    name = input;
                    setState(() {});
                  },
                  title: 'Sur name',
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                getGenderRadioButtons(bloc),
                SizedBox(height: ScreenUtil().setHeight(18)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                  ),
                  child: DateTimeField(
                    decoration: InputDecoration(
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
                  ),
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
                            cvFile = file;
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
                    cvFile == null ? '' : basename(cvFile.path),
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
                      onTap: () {
                        if (bloc.selected == 1) {
                          print('male');
                        } else if (bloc.selected == 2) {
                          print('female');
                        }
                      }),
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
