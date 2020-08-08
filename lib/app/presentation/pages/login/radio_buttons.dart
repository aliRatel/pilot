import 'package:flutter/material.dart';

Row getRadioButtons(bloc) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: RadioListTile(
          title: Text('Company'),
          value: 1,
          onChanged: (val) {
            bloc.changeState(val);
          },
          activeColor: Colors.green,
          groupValue: bloc.selected,
        ),
      ),
      Expanded(
        flex: 2,
        child: RadioListTile(
          title: Text('Job seeker'),
          value: 2,
          onChanged: (val) {
            bloc.changeState(val);
          },
          activeColor: Colors.green,
          groupValue: bloc.selected,
        ),
      ),
    ],
  );
}
