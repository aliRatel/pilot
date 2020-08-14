import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/utils/consts.dart';

class MyTextFormField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final validator;
  final onTextChange;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  final EdgeInsets padding;
  final String title;

  MyTextFormField({
    Key key,
    this.hint = '',
    this.controller,
    this.validator,
    this.onTextChange,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.padding,
    this.title,
  }) : super(key: key);

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(12),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? '',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          TextFormField(
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onTextChange,
            controller: widget.controller,
            style: TextStyle(color: mainColor),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: (BorderRadius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: mainColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: (BorderRadius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: mainColor,
                ),
              ),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
