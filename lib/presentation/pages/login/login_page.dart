import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilot/presentation/pages/login/password_field.dart';
import 'email_field.dart';
import 'login_button.dart';
import 'package:provider/provider.dart';
import 'package:pilot/presentation/providers/selected_radio_button.dart';
import 'package:pilot/presentation/pages/login/radio_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = Provider.of<RadioProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: height / 15,
            left: width / 40,
            right: width / 5,
            bottom: height / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: width / 13)),
            SizedBox(height: height / 80),
            Text('Sign Into Your Account',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: width / 23)),
            Padding(padding: EdgeInsets.only(top: height / 20)),
            getEmailField(width),
            Padding(
                padding: EdgeInsets.only(top: height / 50),
                child: getPasswordField(width)),
            getLoginButton(width, height),
            SizedBox(height: height / 60),
            Text('Forget Password?',
                style: TextStyle(color: Colors.green, fontSize: width / 30)),
            SizedBox(height: height / 50),
            Text('You Are:',
                style: TextStyle(color: Colors.green, fontSize: width / 30)),
            getRadioButtons(bloc),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(fontSize: width / 30)),
                Text("Register Now",
                    style:
                        TextStyle(color: Colors.green, fontSize: width / 30)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
