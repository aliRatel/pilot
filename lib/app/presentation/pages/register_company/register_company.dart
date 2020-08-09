import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/register_company/register_button.dart';
import 'package:pilot/app/presentation/pages/register_company/text_form_field.dart';

import '../login/login_page.dart';

class RegisterCompany extends StatefulWidget {
  @override
  _RegisterCompanyState createState() => _RegisterCompanyState();
}

class _RegisterCompanyState extends State<RegisterCompany> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: height * .2,
                      decoration: BoxDecoration(color: Colors.purpleAccent),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Text(
                      'Pilot',
                      style: TextStyle(
                        fontFamily: 'Satisfy',
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      'Create new company account',
                      style: TextStyle(
                        fontSize: 17,
                        //   fontWeight: FontWeight.bold,
                      ),
                    ),
                    right: 20,
                    top: height * .15,
                  )
                ],
              ),
              RegisterCompanyTextFormField(
                hint: 'Company Name',
                leadingIcon: Icons.title,
              ),
              RegisterCompanyTextFormField(
                hint: 'Country Name',
                leadingIcon: Icons.flag,
              ),
              RegisterCompanyTextFormField(
                hint: 'City',
                leadingIcon: Icons.location_city,
              ),
              RegisterCompanyTextFormField(
                hint: 'ZIP Code',
                leadingIcon: Icons.code,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RegisterCompanyTextFormField(
                      hint: 'Street',
                      leadingIcon: Icons.accessible_forward,
                    ),
                  ),
                  Expanded(
                    child: RegisterCompanyTextFormField(
                      hint: 'Building Number',
                      leadingIcon: Icons.local_parking,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RegisterCompanyTextFormField(
                      hint: 'Phone Number',
                      leadingIcon: Icons.phone,
                    ),
                  ),
                  Expanded(
                    child: RegisterCompanyTextFormField(
                      hint: 'Mobile Number',
                      //leadingIcon: Icons.mob,
                    ),
                  ),
                ],
              ),
              RegisterCompanyTextFormField(
                hint: 'Password',
                leadingIcon: Icons.lock,
              ),
              RegisterCompanyTextFormField(
                hint: 'Confirm Password',
                leadingIcon: Icons.redo,
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: getRegisterButton(width, height, 'Register', () {}),
              ),
              SizedBox(height: 20),
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
      ),
    );
  }
}
