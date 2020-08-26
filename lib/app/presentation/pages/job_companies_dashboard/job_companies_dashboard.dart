import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/add_job.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/title.dart';
import 'package:pilot/app/presentation/pages/job_companies_dashboard/components/job_list/company_job_list.dart';

class JobCompaniesDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          getDashboardTitle(height, width, 'dashboard for job companies'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),

          ),
          getAddJobContainer(
            height,
            width,
          context),
          CompanyJobsList(
            height: height,
            width: width,
            context: context,
          )
        ],
      ),
    );
  }
}
