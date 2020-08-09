import 'package:flutter/material.dart';

Container getRegisterButton(width, height, title, Function onTap) {
  return Container(
    width: width,
    margin: EdgeInsets.only(top: height / 50),
    height: height / 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      gradient: LinearGradient(
        colors: [Colors.green[200], Colors.green[500], Colors.black],
      ),
    ),
    child: GestureDetector(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: width / 20,
        ),
      ),
      onTap: onTap,
    ),
  );
}
