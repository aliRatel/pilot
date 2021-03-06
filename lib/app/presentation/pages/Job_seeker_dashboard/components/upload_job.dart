import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/presentation/pages/search_screen/search_page.dart';

Container getUploadJobContainer(
    double height, double width, BuildContext context) {
  return Container(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  )),
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: Colors.blue[800],
                dashPattern: [4, 15],
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
          ),
        );

}
