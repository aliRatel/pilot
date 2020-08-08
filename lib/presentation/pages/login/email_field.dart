import 'package:flutter/material.dart';

TextFormField getEmailField(width){
  return   TextFormField(
    style: TextStyle(color: Colors.green),
    decoration: InputDecoration(
        hintText: 'enter your email',
        prefixIcon: Icon(Icons.email,color: Colors.green),
        hintStyle: TextStyle(color: Colors.grey,fontSize: width/27)
    ),
  );
}