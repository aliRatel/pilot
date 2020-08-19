import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/job_list/job_list.dart';
import 'components/title.dart';
import 'components/upload_job.dart';

class JobSeekerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          getdashboardTitle(height, width),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Text(
                'Lorem dolor sit amet consecteture adipisicing elit, sed do',
                style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: width * 0.035,
                ),
                textAlign: TextAlign.center),
          ),
          getUploadJobContainer(
            height,
            width,
          ),
          getjobList(
            height,
            width,
          )
        ],
      ),
    );
  }
}
