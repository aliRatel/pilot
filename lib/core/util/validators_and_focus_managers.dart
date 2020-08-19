import 'package:flutter/material.dart';

String validateRequiredTextField(String value) {
  if (value.length > 0) return null;
  return 'this field is required';
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
