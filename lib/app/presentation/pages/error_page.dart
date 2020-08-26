import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/LoadingPage.dart';
import 'package:pilot/core/util/consts.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'something went wrong',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(
              height: 10,
            ),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoadingPage(),));
            },iconSize: 40,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
