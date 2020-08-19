import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/presentation/pages/login/radio_buttons.dart';

import 'package:pilot/app/presentation/pages/register_pages/register_company/register_company_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/register_job_seeker/register_job_seeker_page.dart';
import 'package:pilot/app/presentation/widgets/base_clipper.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';

import '../../../../core/util/consts.dart';
import '../../widgets/my_button.dart';
import '../../widgets/text_form_field.dart';

class BaseRegisterPage extends StatefulWidget {
  @override
  _BaseRegisterPageState createState() => _BaseRegisterPageState();
}

class _BaseRegisterPageState extends State<BaseRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  UserType _userType = UserType.company;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        'Sign Up',
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
                      hint: 'Enter your email',
                      controller: _emailController,
                      focusNode: _emailFocus,
                      validator: (value) => validateRequiredTextField(value),
                      onFieldSubmitted: (input) => fieldFocusChange(
                        context,
                        _emailFocus,
                        _passwordFocus,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    MyTextFormField(
                      obscureText: _hidePassword,
                      validator: (value) => validateRequiredTextField(value),
                      controller: _passwordController,
                      onFieldSubmitted: (input) => fieldFocusChange(
                        context,
                        _passwordFocus,
                        _confirmPasswordFocus,
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _passwordFocus,
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
                    MyTextFormField(
                      obscureText: _hideConfirmPassword,
                      focusNode: _confirmPasswordFocus,
                      controller: _confirmPasswordController,
                      validator: (value) => validateRequiredTextField(value),
                      onFieldSubmitted: (input) => fieldFocusChange(
                        context,
                        _confirmPasswordFocus,
                        null,
                      ),
                      hint: 'Confirm your password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hideConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _hideConfirmPassword = !_hideConfirmPassword;
                          setState(() {});
                        },
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
                    getRadioButtons(
                      (selected) => setState(
                        () => _userType = selected,
                      ),
                      _userType,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(12),
                        left: ScreenUtil().setWidth(12),
                      ),
                      child: myButton(
                          context: context,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            validateAndContinue();
                          }),
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
                          Navigator.of(context).pop();
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

  void validateAndContinue() {
    if (_formKey.currentState.validate()) {
      if (_userType == UserType.jobSeeker) {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (_) => RegisterJobSeekerPage(),
          ),
        )
            .then((value) {
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          _hideConfirmPassword = true;
          _hidePassword = true;
        });
      } else {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (_) => RegisterCompanyPage(),
          ),
        )
            .then((value) {
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          _hideConfirmPassword = true;
          _hidePassword = true;
        });
      }
    }
  }
}
