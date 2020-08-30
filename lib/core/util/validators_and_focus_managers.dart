import 'package:flutter/material.dart';

String validateRequiredTextField(String value) {
  if (value.length > 0) return null;
  return 'this field is required';
}
String validateRequiredAndMatch(String ps1,ps2) {
  if (ps1.length == 0||ps2.length ==0)
  return 'this field is required';
  if(ps1!=ps2) return 'passwords don\'t match';
  return null;
}
void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus,
    {submitAction}) {
  currentFocus.unfocus();
  if (nextFocus == null && submitAction != null) {
    submitAction();
  } else
    FocusScope.of(context).requestFocus(nextFocus);
}
