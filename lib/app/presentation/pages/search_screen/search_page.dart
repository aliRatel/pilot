import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/pages/search_screen/search_box.dart';
import 'package:pilot/app/presentation/widgets/dotted_button.dart';

import 'package:pilot/core/util/consts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0).withOpacity(.99),
      body: Stack(
        children: [
          Container(
            height: size.height * .2,
            color: mainColor,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .085,
                  ),
                  Text(
                    'Dashboard for companies',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  SearchBox(),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Container(
                    height: size.height * .45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        getBrandItem(),
                        getBrandItem(),
                        SizedBox(
                          height: ScreenUtil().setHeight(18),
                        ),
                        DottedButton(
                          backgroundColor: mainColor,
                          dottedColor: mainColor,
                          height: ScreenUtil().setHeight(40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'GO',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: ScreenUtil().setHeight(15),
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return JobItem(size.height, size.width);
                    },
                    itemCount: 4,
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBrandItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10),
            right: ScreenUtil().setWidth(5),
            top: ScreenUtil().setHeight(18),
          ),
          child: Text(
            'VEHICLE  BRAND',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Container(
          height: ScreenUtil().setHeight(45),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlatButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: 8),
            focusColor: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toyota',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
      ],
    );
  }
}
