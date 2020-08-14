import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/login/password_field.dart';
import 'package:pilot/app/presentation/pages/login/radio_buttons.dart';
import 'package:pilot/app/presentation/providers/selected_radio_button.dart';
import 'email_field.dart';
import 'login_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = Provider.of<TypeRadioProvider>(context);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: height * 0.25,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(color: Colors.purpleAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: width / 13),
                        ),
                        SizedBox(height: height / 80),
                        Text(
                          'Sign Into Your Account',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: width / 23,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height / 20),
                        ),
                        getEmailField(width),
                        Padding(
                          padding: EdgeInsets.only(top: height / 50),
                          child: getPasswordField(width),
                        ),
                        getLoginButton(width, height,context),
                        SizedBox(height: height / 60),
                        Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: width / 30,
                          ),
                        ),
                        SizedBox(height: height / 50),
                        Text(
                          'You Are:',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: width / 30,
                          ),
                        ),
                        getRadioButtons(bloc),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?  ",
                              style: TextStyle(
                                fontSize: width / 30,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "  Register Now",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: width / 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
