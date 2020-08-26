import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/country.dart' as COU;
import 'package:pilot/app/presentation/pages/search_screen/search_box.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/widgets/dotted_button.dart';
import 'package:pilot/app/presentation/widgets/my_drop_down_button.dart';

import 'package:pilot/core/util/consts.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    Size size = MediaQuery.of(context).size;
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'search for jobs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Color(0xffF0F0F0).withOpacity(.99),
      body: Stack(
        children: [
          Container(
            height: size.height * .2,
            color: mainColor,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .085,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  SearchBox(),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Container(
                    height: size.height * .45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(15),
                            right: ScreenUtil().setWidth(5),
                            bottom: ScreenUtil().setHeight(8),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Country'),
                          ),
                        ),
                        MyDropDownButton(
                          items: locationProvider.countries,
                          initialValue: locationProvider.selectedCountry,
                          valueChanged: (dynamic newCountry) async {
                            print(newCountry.name);
                            locationProvider.setSelectedCountry(newCountry);
                            print('==================================');
                            print(_selectedCountry.name);
                            // return cities for the selected country id
                            await locationProvider
                                .getCities(locationProvider.selectedCountry.id);

                            fieldFocusChange(
                              context,
                              _countryRegionFocus,
                              _cityFocus,
                            );
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(15),
                            right: ScreenUtil().setWidth(5),
                            bottom: ScreenUtil().setHeight(8),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('City'),
                          ),
                        ),
                        locationProvider
                                .isLoading()
                            ? CircularProgressIndicator()
                            : MyDropDownButton(
                                items: Provider.of<LocationProvider>(context)
                                    .currentCities,
                                initialValue:
                                    Provider.of<LocationProvider>(context)
                                        .selectedCity,
                                valueChanged: (dynamic newCity) {
                                  Provider.of<LocationProvider>(context,
                                          listen: false)
                                      .setSelectedCity(newCity);
                                  fieldFocusChange(context, _cityFocus, null);
                                },
                              ),
                        SizedBox(
                          height: ScreenUtil().setHeight(18),
                        ),
                        DottedButton(
                          backgroundColor: mainColor,
                          dottedColor: mainColor,
                          height: ScreenUtil().setHeight(40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'GO',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: ScreenUtil().setHeight(15),
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // return JobCard(size.height, size.width);
                    },
                    itemCount: 4,
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
