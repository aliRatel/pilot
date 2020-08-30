import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/country.dart' as COU;
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/pages/search_screen/search_box.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/providers/search_page_provider.dart';
import 'package:pilot/app/presentation/widgets/dotted_button.dart';
import 'package:pilot/app/presentation/widgets/my_drop_down_button.dart';
import 'package:pilot/app/presentation/providers/jobSeeker_dashBoardProvider.dart';
import 'package:pilot/core/util/consts.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import 'package:provider/provider.dart';
import 'package:pilot/app/presentation/pages/search_screen/search_job_list.dart';

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

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _willPopCallBack,
      child: Scaffold(
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
        body: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: size.height * .1,
                  color: mainColor,
                ),
//
//
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .01,
                      ),
                      SearchBox(),

                    ],
                  ),
                ),
              ],
            ),
            Container(
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
                    items: Provider.of<LocationProvider>(context,
                        listen: false)
                        .countries,
                    initialValue: Provider.of<LocationProvider>(
                        context,
                        listen: false)
                        .selectedCountry,
                    valueChanged: (dynamic newCountry) async {
                      print(newCountry.name);
                      Provider.of<LocationProvider>(context,
                          listen: false)
                          .setSelectedCountry(newCountry);

                      await Provider.of<LocationProvider>(context,
                          listen: false)
                          .getCities(Provider.of<LocationProvider>(
                          context,
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
                  Provider.of<LocationProvider>(context,
                      listen: false)
                      .isLoading()
                      ? CircularProgressIndicator()
                      : MyDropDownButton(
                    items:
                    Provider.of<LocationProvider>(context)
                        .currentCities,
                    initialValue:
                    Provider.of<LocationProvider>(context)
                        .selectedCity,
                    valueChanged: (dynamic newCity) {
                      Provider.of<LocationProvider>(context,
                          listen: false)
                          .setSelectedCity(newCity);
                      fieldFocusChange(
                          context, _cityFocus, null);
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DottedButton(
                      onTap: () => Provider.of<SearchPageProvider>(
                          context,
                          listen: false)
                          .getJobs(Provider.of<LocationProvider>(
                          context,
                          listen: false)
                          .selectedCity
                          .id),
                      backgroundColor: mainColor,
                      dottedColor: mainColor,
                      height: ScreenUtil().setHeight(40),
                      child: Provider.of<SearchPageProvider>(context,
                          listen: false)
                          .loading
                          ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      )
                          : Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
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
                  ),
                ],
              ),
            ),
            SearchJobsList(
              height: height,
              width: width,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _willPopCallBack() {
    Provider.of<JobSeekerDashBoardProvider>(context, listen: false).getJobs();
    return Future.value(true);
  }
}
