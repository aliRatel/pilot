import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pilot/app/domain/entities/enums/app_action.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/job_seeker_dashboard.dart';
import 'package:pilot/app/presentation/pages/job_companies_dashboard/job_companies_dashboard.dart';
import 'package:pilot/app/presentation/pages/login/login_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/base_register_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_company/register_company_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_job_seeker/register_job_seeker_page.dart';
import 'package:pilot/app/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => func(context));
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

func(BuildContext context) async {
  Provider.of<UserProvider>(context, listen: false)
      .checkForUsers()
      .then((value) {
    var action = Provider.of<UserProvider>(context, listen: false).neededAction;

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => mapAction(action),
        ));
  });
}

mapAction(AppAction action) {
  switch (action) {
    case AppAction.signUp:
      return BaseRegisterPage();
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
