import 'package:flutter/material.dart';
import 'file:///C:/Users/ali/Desktop/pilot/lib/core/util/consts.dart';

Widget getGenderRadioButtons(bloc) {
  // 1 > Male  ||  2 >  Female
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RadioListTile(
        title: Text('Male'),
        value: 1,
        onChanged: (val) {
          bloc.changeState(val);
        },
        activeColor: mainColor,
        groupValue: bloc.selected,
      ),
      RadioListTile(
        title: Text('Female'),
        value: 2,
        onChanged: (val) {
          bloc.changeState(val);
        },
        activeColor: mainColor,
        groupValue: bloc.selected,
      ),
    ],
  );
}
