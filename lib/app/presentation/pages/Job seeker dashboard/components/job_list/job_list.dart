import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'my_button.dart';

getjobList(double height, double width) {
  return Expanded(
    child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return JobItem(height, width);
        }),
  );
}

class JobItem extends StatelessWidget {
  final double height;
  final double width;

  const JobItem(this.height, this.width, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text('UX,UI Designer',
              style: TextStyle(
                  fontSize: width * 0.035,
                  color: Colors.blue[500],
                  fontWeight: FontWeight.bold)),
          Text('Marie Nathalie', style: TextStyle(fontSize: width * 0.033)),
          Text('8 Nov',
              style: TextStyle(fontSize: width * 0.033, color: Colors.grey)),
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
                        fontSize: width * 0.033, color: Colors.blue[500])),
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
