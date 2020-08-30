import 'package:flutter/material.dart';

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

    final double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height*.8);
    path.quadraticBezierTo(  rect.size.width/4, rect.size.height/4,rect.size.width/2,rect.size.height/2,);
    path.quadraticBezierTo(  rect.size.width*3/4, rect.size.height*3/4,rect.size.width,0,);

    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}