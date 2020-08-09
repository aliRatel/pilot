import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/login/login_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_company/register_button.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_company/text_form_field.dart';


class CompleteRegisterCompany extends StatefulWidget {
  @override
  _CompleteRegisterCompanyState createState() =>
      _CompleteRegisterCompanyState();
}

class _CompleteRegisterCompanyState extends State<CompleteRegisterCompany> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                        'Complete the account information',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: getRegisterButton(width, height, 'Finnish', () {}),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
