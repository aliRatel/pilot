import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/presentation/providers/jobSeeker_dashBoardProvider.dart';
import 'package:provider/provider.dart';
import 'package:pilot/app/domain/entities/job.dart';

import 'my_button.dart';

class JobCard extends StatelessWidget {
  final double height;
  final double width;
final Job job;
  const JobCard(this.height, this.width, this.job, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Provider.of<JobSeekerDashBoardProvider>(context).isLoading()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: height * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
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
                Text(job.title,
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold)),
                Text(job.companyName,
                    style: TextStyle(fontSize: width * 0.033)),
                Text('8 Nov',
                    style:
                        TextStyle(fontSize: width * 0.033, color: Colors.grey)),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(18)),
                    child: Text(
                        'We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained',
                        style: TextStyle(
                            fontSize: width * 0.035, color: Colors.blueGrey),
                        textAlign: TextAlign.start)),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Roseville',
                              style: TextStyle(
                                  fontSize: width * 0.033, color: Colors.grey)),
                          Text('/United States',
                              style: TextStyle(fontSize: width * 0.033)),
                        ],
                      ),
                      Text('23 app',
                          style: TextStyle(
                              fontSize: width * 0.033,
                              color: Colors.blue[500])),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: getMyButton(width, 'Apply'),
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
          );
  }
}

class JobsList extends StatefulWidget {
  const JobsList({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  var _jobs = [];
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
        onNotification: (t) {
          if (t is ScrollEndNotification) {
            print('end of list');
            Provider.of<JobSeekerDashBoardProvider>(context).getJobs(pageNumber).then((value) {
              if(value!=null && value.length!=0){
                var newJobs = value.map((e) => JobCard(widget.height , widget.width, e)).toList();
                setState(() {

                  _jobs=_jobs+newJobs;
                });
              }
            });

          }
          return true;
        },
        child: ListView.builder(
          itemCount: _jobs.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            return JobCard(widget.height, widget.width,_jobs.elementAt(index));
          },
        ),
      ),
    );
  }
}
