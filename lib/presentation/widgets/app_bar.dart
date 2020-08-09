import 'package:flutter/material.dart';

AppBar getAppBar(String text, double width) {
  return AppBar(
      title: Text(text,
          style: TextStyle(fontSize: width / 14, fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: Colors.black,
      leading: text == 'DashBoard' ? Text('') : null);
}
