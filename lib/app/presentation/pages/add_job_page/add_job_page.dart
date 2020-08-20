import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/title.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/upload_job.dart';
import 'package:pilot/app/presentation/widgets/my_button.dart';
import 'package:pilot/app/presentation/widgets/text_form_field.dart';
import 'package:pilot/core/util/consts.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';


    class AddJobPage extends StatefulWidget {
      @override
      _AddJobPageState createState() => _AddJobPageState();
    }

    
    class _AddJobPageState extends State<AddJobPage> {
      List<String> countries = [];
      List<String> cities = [];

      String selectedCountry = '';
      String selectedCity = '';

      final _addJobKey = GlobalKey<FormState>();
      TextEditingController _titleControoler = TextEditingController();
      TextEditingController _skillsControoler = TextEditingController();
      TextEditingController _descriptionsControoler = TextEditingController();

      final FocusNode _titleFocus = FocusNode();
      final FocusNode _skillsFocus = FocusNode();
      final FocusNode _descriptionFocus = FocusNode();


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
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        return Scaffold(
          body: ListView(
            children: [
              Form(
                key: _addJobKey,
                child: Column(
                  children: [
                    getDashboardTitle(height,width,'create a new job'),
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
                      validator: (value) => value.iSEmpty? "title cannot be empty.": null,
                      onFieldSubmitted: (input) =>
                      fieldFocusChange(context, _titleFocus, _skillsFocus),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,                      focusNode: _titleFocus,
                    ),

                    MyTextFormField(
                      onTextChange: (String input) {
                        setState(() {});
                      },
                      hint: 'Skills',
                      controller: _skillsControoler,
                      title: 'Skills',
                      validator: (val){
                        val.isEmpty ? "Skills cannot be empty.": null ;
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
                      maxlines: 5,
                      hint: 'description',
                      controller: _titleControoler,
                      title: 'Description',
                      validator: (value) => value.iSEmpty? "description cannot be empty.": null,
                      //onFieldSubmitted: (input) =>
                      //fieldFocusChange(context, _titleFocus, null),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,                      focusNode: _descriptionFocus,
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
                    Container(
                      height: ScreenUtil().setHeight(55),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      width: width*.95,
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
                                (country) =>
                                DropdownMenuItem<String>(
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
                        horizontal: ScreenUtil().setWidth(10),
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
                                  (city) =>
                                  DropdownMenuItem<String>(
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
                          }

                          ),
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
        if (_addJobKey.currentState.validate()) {

        }
      }








    }
    