import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/title.dart';
import 'package:pilot/app/domain/entities/country.dart' as COU;
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/widgets/my_button.dart';
import 'package:pilot/app/presentation/widgets/my_drop_down_button.dart';
import 'package:pilot/app/presentation/widgets/text_form_field.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import 'package:provider/provider.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _addJobKey = GlobalKey<FormState>();
  TextEditingController _titleControoler = TextEditingController();
  TextEditingController _skillsControoler = TextEditingController();
  TextEditingController _descriptionsControler = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _skillsFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _countryRegionFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  COU.Country _selectedCountry;
  City _selectedCity;

  DateTime _birthday;

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: _addJobKey,
            child: Column(
              children: [
                getDashboardTitle(height, width, 'create a new job'),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Text(
                        'Lorem dolor sit amet consecteture \n adipisicing elit, sed do',
                        style: TextStyle(
                            color: Colors.blue[500], fontSize: width * 0.045),
                        textAlign: TextAlign.center)),
                SizedBox(height: ScreenUtil().setHeight(30)),

                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  hint: 'title',
                  controller: _titleControoler,
                  title: 'Title',
                  validator: (value) =>
                      value.iSEmpty ? "title cannot be empty." : null,
                  onFieldSubmitted: (input) =>
                      fieldFocusChange(context, _titleFocus, _skillsFocus),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _titleFocus,
                ),

                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  hint: 'Skills',
                  controller: _skillsControoler,
                  title: 'Skills',
                  validator: (val) {
                    val.isEmpty ? "Skills cannot be empty." : null;
                  },
                  onFieldSubmitted: (input) =>
                      fieldFocusChange(context, _titleFocus, _descriptionFocus),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _skillsFocus,
                ),

                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  maxLines: 5,
                  hint: 'description',
                  controller: _titleControoler,
                  title: 'Description',
                  validator: (value) =>
                      value.iSEmpty ? "description cannot be empty." : null,
                  //onFieldSubmitted: (input) =>
                  //fieldFocusChange(context, _titleFocus, null),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  focusNode: _descriptionFocus,
                ),

                // SizedBox(height: ScreenUtil().setHeight(30)),

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
                    print(newCountry.name);
                    locationProvider.setSelectedCountry(newCountry);
                    print('==================================');
                    print(_selectedCountry.name);
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
                        items: Provider.of<LocationProvider>(context)
                            .currentCities,
                        initialValue:
                            Provider.of<LocationProvider>(context).selectedCity,
                        valueChanged: (dynamic newCity) {
                          Provider.of<LocationProvider>(context, listen: false)
                              .setSelectedCity(newCity);
                          fieldFocusChange(context, _cityFocus, null);
                        },
                      ),
                SizedBox(height: ScreenUtil().setHeight(18)),

                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: myButton(
                      context: context,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        validateAndRegisterCompany();
                      }),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validateAndRegisterCompany() {
    if (_addJobKey.currentState.validate()) {}
  }
}
