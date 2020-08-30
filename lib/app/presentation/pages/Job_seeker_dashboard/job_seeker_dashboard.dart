import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilot/core/util/consts.dart';

import 'components/job_list/job_list.dart';
import 'components/upload_job.dart';
import 'package:pilot/app/presentation/widgets/custom_shape_border.dart';

class JobSeekerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            backgroundColor: mainColor,
            title: Text('Recent Jobs'),
            centerTitle: true,
            shape: CustomShapeBorder(),
          )),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          ),
          getUploadJobContainer(height, width, context),
          JobsList(
            height: height,
            width: width,
            context: context,
          )
        ],
      ),
    );
  }
}
