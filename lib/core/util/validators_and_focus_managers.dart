import 'package:flutter/cupertino.dart';

bool validateRequiredTextField(String value) {
  if (value.length > 0) return true;
  return false;
}

void fieldFocusChange(BuildContext context, FocusNode currentFocus,
    FocusNode nextFocus, {submitAction}) {
  currentFocus.unfocus();
  if (nextFocus == null && submitAction !=null) {
    submitAction();
  }  else
    FocusScope.of(context).requestFocus(nextFocus);
}
