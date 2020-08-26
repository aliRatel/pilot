import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pilot/app/domain/entities/enums/app_action.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/job_seeker_dashboard.dart';
import 'package:pilot/app/presentation/pages/error_page.dart';
import 'package:pilot/app/presentation/pages/job_companies_dashboard/job_companies_dashboard.dart';
import 'package:pilot/app/presentation/pages/login/login_page.dart';
import 'package:pilot/app/presentation/pages/on_boarding/main_onbaording_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/base_register_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_company/register_company_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_job_seeker/register_job_seeker_page.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/providers/user_provider.dart';
import 'package:pilot/core/util/consts.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 200), () {
        func(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          height: MediaQuery
              .of(context)
              .size
              .height * 0.25,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.25,
        ),
      ),
    );
  }
}

func(BuildContext context) async {
  await Future.delayed(Duration(seconds: 1), () => null);
  bool result = await Provider.of<LocationProvider>(context, listen: false)
      .getCountries();
  if (!result) {
    print(result);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ErrorPage(),));
    return;
  }
  Provider.of<UserProvider>(context, listen: false)
      .checkForUsers()
      .then((value) {
    var action = Provider
        .of<UserProvider>(context, listen: false)
        .neededAction;

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => mapAction(action),
        ));
  });
}

mapAction(AppAction action) {
  return RegisterJobSeekerPage();

  switch (action) {
    case AppAction.signUp:
      return OnBoarding();
    case AppAction.CompleteCompanyInfo:
      return RegisterCompanyPage();
    case AppAction.CompleteJobSeekerInfo:
      return RegisterJobSeekerPage();
    case AppAction.JobSeekerDashBoard:
      return JobSeekerDashboard();
    case AppAction.CompanyDashBoard:
      return JobCompaniesDashboard();
  }
}
