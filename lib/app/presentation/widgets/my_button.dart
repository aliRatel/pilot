import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/consts.dart';

Widget myButton({
  @required BuildContext context,
  Function onTap,
  Widget child,
  bool isEnabled
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(
      top: ScreenUtil().setHeight(12),
    ),
    height: ScreenUtil().setHeight(50),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: FlatButton(

      onPressed: onTap,
      child: Center(
        child: child

      ),
    ),
  );
}
