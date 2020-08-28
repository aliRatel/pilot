import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/title.dart';
import 'package:pilot/app/domain/entities/country.dart' as COU;
import 'package:pilot/app/presentation/pages/job_companies_dashboard/job_companies_dashboard.dart';
import 'package:pilot/app/presentation/providers/add_job_provider.dart';
import 'package:pilot/app/presentation/providers/company_dashBoard_provider.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/widgets/my_button.dart';
import 'package:pilot/app/presentation/widgets/my_drop_down_button.dart';
import 'package:pilot/app/presentation/widgets/text_form_field.dart';
import 'package:pilot/core/util/consts.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import 'package:provider/provider.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();
  TextEditingController _descriptionsController = TextEditingController();
  TextEditingController _abstractController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _skillsFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _countryRegionFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _abstractFocus = FocusNode();

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

  void _submit() {
    if (!_formKey.currentState.validate()) return;
    String title = _titleController.text.trim();
    String skills = _skillsController.text.trim();
    String description = _descriptionsController.text.trim();
    String abstract = _abstractController.text.trim();
    int cityId =
        Provider.of<LocationProvider>(context, listen: false).selectedCity.id;
    int countryId = Provider.of<LocationProvider>(context, listen: false)
        .selectedCountry
        .id;
    Provider.of<AddJobProvider>(context, listen: false).setMessage(null);
    Provider.of<AddJobProvider>(context, listen: false)
        .addJob(title, skills, countryId, cityId, abstract, description)
        .then((value) async {
      if (value) {
        Provider.of<CompanyDashBoardProvider>(context,listen: false).getJobs();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(backgroundColor: mainColor,title: Text('Create a new job'),),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
//                getDashboardTitle(height, width, 'create a new job'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),

                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  hint: 'title',
                  controller: _titleController,
                  title: 'Title',
                  validator: (value) => validateRequiredTextField(value),
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
                  controller: _skillsController,
                  title: 'Skills',
                  validator: (value) => validateRequiredTextField(value),
                  onFieldSubmitted: (input) =>
                      fieldFocusChange(context, _skillsFocus, _abstractFocus),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _skillsFocus,
                ),
                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  hint: 'abstract',
                  controller: _abstractController,
                  title: 'abstract',
                  validator: (value) => validateRequiredTextField(value),
                  onFieldSubmitted: (input) => fieldFocusChange(
                      context, _abstractFocus, _descriptionFocus),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _abstractFocus,
                ),
                MyTextFormField(
                  onTextChange: (String input) {
                    setState(() {});
                  },
                  maxLines: 5,
                  hint: 'description',
                  controller: _descriptionsController,
                  title: 'Description',
                  validator: (value) => validateRequiredTextField(value),
                  onFieldSubmitted: (input) =>
                      fieldFocusChange(context, _titleFocus, null),
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
                  items: Provider.of<LocationProvider>(context, listen: false)
                      .countries,
                  initialValue:
                      Provider.of<LocationProvider>(context, listen: false)
                          .selectedCountry,
                  valueChanged: (dynamic newCountry) async {
                    print(newCountry.name);
                    Provider.of<LocationProvider>(context, listen: false)
                        .setSelectedCountry(newCountry);
                    print('==================================');
                    print(_selectedCountry.name);
                    await Provider.of<LocationProvider>(context, listen: false)
                        .getCities(Provider.of<LocationProvider>(context,
                                listen: false)
                            .selectedCountry
                            .id);

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
                Provider.of<LocationProvider>(context, listen: false)
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
                          fieldFocusChange(context, _cityFocus, null);
                        },
                      ),
                SizedBox(height: ScreenUtil().setHeight(18)),

                Padding(
                    padding: EdgeInsets.all(12.0),
                    child: myButton(
                      context: context,
                      child: Provider.of<AddJobProvider>(context)
                              .loading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Add job',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      onTap:
                          !Provider.of<AddJobProvider>(context, listen: false)
                                  .isLoading()
                              ? () {
                                  _submit();
                                }
                              : null,
                    )),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validateAndRegisterCompany() {
    if (_formKey.currentState.validate()) {}
  }
}
