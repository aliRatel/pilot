import 'package:flutter/material.dart';

FlatButton getMyButton(double width, String title) {
  return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.blue[800])),
      child: Text(title,
          style: TextStyle(
              fontSize: width * 0.033,
              color: title == 'Apply' ||title=='Delete'? Colors.white : Colors.black,
              fontWeight: FontWeight.bold)),
      onPressed: () {},
      color: title == 'Apply'  ? Colors.blue[800] : title=='Delete'?Colors.red[800]:Colors.white);
}
