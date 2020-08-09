import 'package:flutter/material.dart';

TextFormField getPasswordField(width){
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        hintText: 'enter your password',
        hintStyle: TextStyle(color: Colors.grey,fontSize: width/27),
        prefixIcon: Icon(Icons.lock,color: Colors.green)
    ),
  );
}