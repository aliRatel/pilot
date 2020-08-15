import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

Container getUploadJobContainer(double height, double width) {
  return Container(
    padding: EdgeInsets.only(
        top: height * 0.1, left: width * 0.015, right: width * 0.015),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload JOB',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04)),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Container(
          alignment: Alignment.center,
          height: height * 0.28,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: DottedBorder(
            borderType: BorderType.Circle,
            color: Colors.blue[800],
            dashPattern: [4,15],
            padding: EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(20)),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[800],
                  border: Border.all(color: Colors.white, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 4.0),
                        color: Colors.grey,
                        blurRadius: 10.0)
                  ]),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
