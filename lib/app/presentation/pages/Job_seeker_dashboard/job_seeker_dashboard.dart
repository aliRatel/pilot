import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/job_list/job_list.dart';
import 'components/title.dart';
import 'components/upload_job.dart';

class JobSeekerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Column(
          children: [
          getDashboardTitle(height, width, 'job seeker dashboard'),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),

      ),
      getUploadJobContainer(height, width, context),
      JobsList(height: height, width: width,context: context,)
      ],
    ),);
  }
}



