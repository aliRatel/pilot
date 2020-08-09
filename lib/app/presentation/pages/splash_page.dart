import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Center(
            child: Text('Pilot',
                style: TextStyle(
                    fontFamily: 'Satisfy',
                    color: Colors.white,
                    fontSize: width / 5))),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green[200], Colors.green[900]],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
      ),
    );
  }
}
