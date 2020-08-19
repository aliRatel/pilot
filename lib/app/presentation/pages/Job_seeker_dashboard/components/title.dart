import 'package:flutter/material.dart';

Container getDashboardTitle(double height, double width, String title){
  return  Container(
    margin: EdgeInsets.only(bottom: height * 0.05),
    height: height * 0.15,
    color: Colors.blue[800],
    alignment: Alignment.center,
    child: Text(title,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05)),
  );
}