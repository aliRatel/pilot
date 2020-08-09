import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/register_company/complete-register_company.dart';
import 'package:pilot/app/presentation/pages/register_company/register_button.dart';
import 'package:pilot/app/presentation/pages/register_company/text_form_field.dart';
import 'package:provider/provider.dart';

import '../../providers/selected_radio_button.dart';
import '../login/login_page.dart';
import '../login/radio_buttons.dart';

class BaseRegisterPage extends StatefulWidget {
  @override
  _BaseRegisterPageState createState() => _BaseRegisterPageState();
}

class _BaseRegisterPageState extends State<BaseRegisterPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = Provider.of<RadioProvider>(context);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: width / 13),
                      ),
                      SizedBox(height: height / 80),
                      Text(
                        'Create Your Account',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: width / 23),
                      ),
                      Padding(padding: EdgeInsets.only(top: height / 20)),
                      RegisterCompanyTextFormField(
                        hint: 'Enter your email',
                        leadingIcon: Icons.email,
                      ),
                      RegisterCompanyTextFormField(
                        hint: 'Enter your Password',
                        leadingIcon: Icons.lock,
                      ),
                      RegisterCompanyTextFormField(
                        hint: 'Confirm your password',
                        leadingIcon: Icons.redo,
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: getRegisterButton(width, height, 'Register', () {
                          print(bloc.selected);
                          if (bloc.selected == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CompleteRegisterCompany(),
                              ),
                            );
                          }
                        }),
                      ),
                      SizedBox(height: height / 60),
                      Text(
                        'You Are:',
                        style: TextStyle(
                            color: Colors.green, fontSize: width / 30),
                      ),
                      getRadioButtons(bloc),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'HAVE ACCOUNT?  LOGIN',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
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
