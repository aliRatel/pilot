import 'package:flutter/material.dart';

class RegisterCompanyTextFormField extends StatefulWidget {
  final String hint;
  final IconData leadingIcon;
  final TextEditingController controller;
  final validator;
  final onTextChange;
  final TextInputType keyboardType;

  RegisterCompanyTextFormField({
    Key key,
    this.hint = '',
    this.leadingIcon,
    this.controller,
    this.validator,
    this.onTextChange,
    this.keyboardType,
  }) : super(key: key);

  @override
  _RegisterCompanyTextFormFieldState createState() =>
      _RegisterCompanyTextFormFieldState();
}

class _RegisterCompanyTextFormFieldState
    extends State<RegisterCompanyTextFormField> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onTextChange,
        controller: widget.controller,
        style: TextStyle(color: Colors.green),
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: Icon(widget.leadingIcon, color: Colors.green),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: width / 27,
          ),
        ),
      ),
    );
  }
}
