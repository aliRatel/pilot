import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/add_job.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/title.dart';
import 'package:pilot/app/presentation/pages/job_companies_dashboard/components/job_list/company_job_list.dart';
import 'package:pilot/core/util/consts.dart';
import 'package:pilot/app/presentation/widgets/custom_shape_border.dart';

class JobCompaniesDashboard extends StatelessWidget {
final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor:Colors.white,appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: AppBar(
          backgroundColor: mainColor,
          title: Text('My DashBoard'),
          centerTitle: true,
          shape: CustomShapeBorder(),
        )),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          ),
          getAddJobContainer(
            height,
            width,
            context,

          ),
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
