import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/presentation/pages/login/radio_buttons.dart';
import 'package:pilot/app/presentation/pages/register_pages/base_register_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_job_seeker/register_job_seeker_page.dart';

import 'package:pilot/app/presentation/providers/login_provider.dart';
import 'package:pilot/app/presentation/providers/selected_radio_button.dart';
import 'package:pilot/app/presentation/widgets/base_clipper.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/consts.dart';
import '../../widgets/my_button.dart';
import '../../widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _hidePassword = true;
  UserType _userType = UserType.company;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (!_formKey.currentState.validate()) return;

    Provider.of<LogInProvider>(context, listen: false).setMessage(null);
    Provider.of<LogInProvider>(context, listen: false)
        .loginUser(
            email: _emailController.text,
            password: _passwordController.text,
            userType: UserType.company)
        .then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => RegisterJobSeekerPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TypeRadioProvider>(context);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                      focusNode: _emailFocus,
                      onFieldSubmitted: (term) => fieldFocusChange(
                          context, _emailFocus, _passwordFocus),
                      textInputAction: TextInputAction.next,
                      validator: (value) => validateRequiredTextField(value),
                      controller: _emailController,
                      hint: 'Enter your email',
                    ),
                    // SizedBox(height: ScreenUtil().setHeight(3)),
                    MyTextFormField(
                      onFieldSubmitted: (term) =>
                          fieldFocusChange(context, _passwordFocus, null),
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done,
                      obscureText: _hidePassword,
                      validator: (value) => validateRequiredTextField(value),
                      controller: _passwordController,
                      hint: 'Enter your Password',
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
                    getRadioButtons(
                        (selected) => setState(() => _userType = selected),
                        _userType),
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
                        onTap:
                            !Provider.of<LogInProvider>(context, listen: false)
                                    .isLoading()
                                ? () {
                                    _login();
                                  }
                                : null,
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
