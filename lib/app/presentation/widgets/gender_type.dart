import 'package:flutter/material.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';

import '../../../core/util/consts.dart';

Widget getGenderRadioButtons(func, selected) {
  // 1 > Male  ||  2 >  Female
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RadioListTile(
        title: Text('Male'),
        value: UserGender.male,
        onChanged: (val) {
          func(val);
        },
        activeColor: mainColor,
        groupValue: selected,
      ),
      RadioListTile(
        title: Text('Female'),
        value: UserGender.female,
        onChanged: (val) {
          func(val);
        },
        activeColor: mainColor,
        groupValue: selected,
      ),
    ],
  );
}
