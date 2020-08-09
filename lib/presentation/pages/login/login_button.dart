import 'package:flutter/material.dart';
import 'package:pilot/presentation/pages/dash_board/users/dash_board.dart';

Container getLoginButton(width, height, BuildContext context) {
  return Container(
    width: width,
    margin: EdgeInsets.only(top: height / 50),
    height: height / 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [Colors.green[200], Colors.green[500], Colors.black],
        )),
    child: GestureDetector(
      child: Text('Login',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width / 20)),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      ),
    ),
  );
}
