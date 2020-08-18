import 'package:flutter/material.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import '../../../../core/util/consts.dart';

Widget getRadioButtons(func,selected) {
  // 1 > company  ||  2 >  job seeker
  return Column(

    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RadioListTile(
        title: Text('Company'),
        value: UserType.company,
        onChanged: (val) {
         func(val);
          //bloc.changeState(val);
        },
        activeColor: mainColor,
        groupValue: selected,
      ),
      RadioListTile(
        title: Text('Job seeker'),
        value: UserType.jobSeeker,
        onChanged: (val) {

          func(val);
          //bloc.changeState(val);
        },
        activeColor: mainColor,
        groupValue: selected,
      ),
    ],
  );
}
