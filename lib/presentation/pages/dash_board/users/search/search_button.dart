import 'package:flutter/material.dart';

getSearchButton(double height, double width) {
  return Padding(
    padding: EdgeInsets.only(top: height / 30),
    child: RaisedButton(
      child: Text('Search',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width / 23)),
      onPressed: () {},
      color: Colors.green,
    ),
  );
}
