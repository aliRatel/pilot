import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/providers/company_dashBoard_provider.dart';
import 'package:provider/provider.dart';
import 'package:pilot/app/domain/entities/job.dart';

import 'my_button.dart';

class CompanyJobCard extends StatelessWidget {
  final double height;
  final double width;
  final Job job;

  const CompanyJobCard(this.height, this.width, this.job, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return job == null
        ? Container(
            height: 1,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: height * 0.33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(color: Colors.lightBlue, spreadRadius: 1),
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                right: ScreenUtil().setWidth(10),
                left: ScreenUtil().setWidth(10),
                top: ScreenUtil().setHeight(15),
                bottom: ScreenUtil().setHeight(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    job.companyName,
                    style: TextStyle(fontSize: width * 0.033),
                  ),
                  Text(
                    '8 Nov',
                    style:
                        TextStyle(fontSize: width * 0.033, color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(18),
                    ),
                    child: Text(
                        'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained',
                        style: TextStyle(
                            fontSize: width * 0.035, color: Colors.blueGrey),
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Roseville',
                              style: TextStyle(
                                  fontSize: width * 0.033, color: Colors.grey),
                            ),
                            Text(
                              '/United States',
                              style: TextStyle(fontSize: width * 0.033),
                            ),
                          ],
                        ),
                        Text(
                          '23 app',
                          style: TextStyle(
                            fontSize: width * 0.033,
                            color: Colors.blue[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: getMyButton(width, 'Delete'),
                          flex: 1,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(18)),
                        Expanded(
                          child: getMyButton(width, 'View'),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class CompanyJobsList extends StatefulWidget {
  const CompanyJobsList(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.context})
      : super(key: key);

  final double height;
  final double width;
  final BuildContext context;

  @override
  _CompanyJobsListState createState() => _CompanyJobsListState();
}

class _CompanyJobsListState extends State<CompanyJobsList> {
  ScrollController _controller;

  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<CompanyDashBoardProvider>(widget.context, listen: false)
            .getJobs());
    _controller.addListener(_scrollEndListener);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<CompanyDashBoardProvider>(
      widget.context,
      listen: false,
    ).isInitLoading()
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: Provider.of<CompanyDashBoardProvider>(widget.context,
                      listen: false)
                  .jobs
                  .length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return CompanyJobCard(
                    widget.height,
                    widget.width,
                    Provider.of<CompanyDashBoardProvider>(widget.context,
                            listen: true)
                        .jobs
                        .elementAt(index));
              },
            ),
          );
  }

  void _scrollEndListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      Provider.of<CompanyDashBoardProvider>(widget.context, listen: false)
          .getJobs();
    }
  }
}
