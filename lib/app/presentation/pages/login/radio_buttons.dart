import 'package:flutter/material.dart';
import '../../../../core/util/consts.dart';

Widget getRadioButtons(bloc) {
  // 1 > company  ||  2 >  job seeker
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RadioListTile(
        title: Text('Company'),
        value: 1,
        onChanged: (val) {
          bloc.changeState(val);
        },
        activeColor: mainColor,
        groupValue: bloc.selected,
      ),
      RadioListTile(
        title: Text('Job seeker'),
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
