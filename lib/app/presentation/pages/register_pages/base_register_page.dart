import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilot/app/presentation/pages/login/radio_buttons.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_company/complete-register_company_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_job_seeker/register_job_seeker_page.dart';
import 'file:///D:/bebo_flutter/pilot/lib/presentation/widgets/text_form_field.dart';
import 'package:pilot/app/presentation/providers/selected_radio_button.dart';
import 'package:pilot/presentation/widgets/my_button.dart';
import 'package:pilot/utils/consts.dart';
import 'package:provider/provider.dart';

class BaseRegisterPage extends StatefulWidget {
  @override
  _BaseRegisterPageState createState() => _BaseRegisterPageState();
}

class _BaseRegisterPageState extends State<BaseRegisterPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TypeRadioProvider>(context);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(130),
                  decoration: BoxDecoration(color: mainColor),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    MyTextFormField(
                      hint: 'Enter your email',
                    ),
                    SizedBox(height: ScreenUtil().setHeight(3)),
                    MyTextFormField(
                      hint: 'Enter your Password',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(3)),
                    MyTextFormField(
                      hint: 'Confirm your password',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      child: Text(
                        'Work Nature',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    getRadioButtons(bloc),
                    Padding(
                      padding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(12),
                        left: ScreenUtil().setWidth(12),
                      ),
                      child: myButton(
                        context: context,
                        title: 'Sign Up',
                        onTap: () {
                          if (bloc.selected == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CompleteRegisterCompany(),
                              ),
                            );
                          }
                          if (bloc.selected == 2) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RegisterJobSeekerPage(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(35)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(20),
                              right: ScreenUtil().setWidth(10),
                            ),
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'or connect with',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            margin: EdgeInsets.only(
                              right: ScreenUtil().setWidth(20),
                              left: ScreenUtil().setWidth(10),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(35)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.twitter,
                            color: Color(0xff1A8FD7),
                            size: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Color(0xff3B5DA0),
                            size: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.instagram,
                            size: 40,
                            color: Color(
                              0xff6B1D4C,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // go to login page
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'have an account? ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '  Signin',
                                style: TextStyle(
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(45),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
