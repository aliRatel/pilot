import 'package:flutter/material.dart';

getSearchField(String text) {
  return TextFormField(
    decoration: InputDecoration(
      hintText: text,
      filled: true,
      fillColor: Colors.grey[200],
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent)),
    ),
  );
}
