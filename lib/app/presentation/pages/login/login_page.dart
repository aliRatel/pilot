
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/presentation/pages/login/radio_buttons.dart';
import 'package:pilot/app/presentation/pages/register_pages/base_register_page.dart';

import 'package:pilot/app/presentation/providers/company_provider.dart';
import 'package:pilot/app/presentation/providers/selected_radio_button.dart';
import 'package:pilot/app/presentation/widgets/base_clipper.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/consts.dart';
import '../../widgets/my_button.dart';
import '../../widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  bool _hidePassword = true;
  int _workNature = 0;

  TextEditingController _emailController = TextEditingController();
  String _emailErrorMessage;
  TextEditingController _passwordController = TextEditingController();
  String _passwordErrorMessage;

  void _login() {
    if (_emailController.text == '') {
      setState(() {
        _emailErrorMessage = 'this field is required';
      });

    } else if (_passwordController.text == '') {
      setState(() {
        _emailErrorMessage = null;

        _passwordErrorMessage = 'this field is required';
      });
    } else {
      setState(() {
        _passwordErrorMessage = null;
        _emailErrorMessage = null;
      });
      Provider.of<LogInProvider>(context, listen: false).setMessage(null);
      Provider.of<LogInProvider>(context, listen: false)
          .registerCompany(
              email: _emailController.text,
              password: _passwordController.text,
              userType: UserType.company)
          .then((value) {
        if (value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BaseRegisterPage()));
        }
      });
    }
  }

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
                ClipPath(
                  clipper: BaseCLipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(130),
                    decoration: BoxDecoration(color: mainColor),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
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
                      errorText: _emailErrorMessage,
                      controller: _emailController,
                      hint: 'Enter your email',
                    ),
                    // SizedBox(height: ScreenUtil().setHeight(3)),
                    MyTextFormField(
                      controller: _passwordController,
                      hint: 'Enter your Password',
                      errorText: _passwordErrorMessage,
                      suffixIcon: IconButton(
                        icon: Icon(_hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          _hidePassword = !_hidePassword;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(16)),
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
                        child: Provider.of<LogInProvider>(context).loading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 2,
                              )
                            : Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        onTap: !Provider.of<LogInProvider>(context,
                            listen: false)
                            .isLoading()? () {

                          _login();
                          if (bloc.selected == 1) {
                            // go to job seeker home page
                          }
                          if (bloc.selected == 2) {
                            // go to company home page
                          }
                        }:null,
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
                          GestureDetector(
                            child: Icon(
                              FontAwesomeIcons.twitter,
                              color: Color(0xff1A8FD7),
                              size: 40,
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: Color(0xff3B5DA0),
                              size: 40,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              size: 40,
                              color: Color(
                                0xff6B1D4C,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => BaseRegisterPage(),
                            ),
                          );
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
                                text: '  Sign Up',
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
