import 'package:flutter/material.dart';

Container getdashboardTitle(double height, double width){
  return  Container(
    margin: EdgeInsets.only(bottom: height * 0.05),
    height: height * 0.15,
    color: Colors.blue[800],
    alignment: Alignment.center,
    child: Text('dashboard for job seekers',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05)),
  );
}