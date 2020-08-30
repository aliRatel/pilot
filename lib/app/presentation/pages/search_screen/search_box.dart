import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilot/core/util/validators_and_focus_managers.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final FocusNode _searchFocus = FocusNode();
  TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
        ),
        width: double.infinity,
        height: ScreenUtil().setHeight(50.0),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: _searchFocus,
                  controller: _searchController,
                  validator: (value) => validateRequiredTextField(value),
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (input) => fieldFocusChange(
                    context,
                    _searchFocus,
                    null,
                    submitAction: _search,
                  ),
                  style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    contentPadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(14.0),
                      bottom: ScreenUtil().setHeight(12.0),
                      top: 0.0,
                    ),
                    errorStyle: TextStyle(fontSize: 10),
                    errorMaxLines: 1,
                    suffixIcon: Icon(
                      Icons.mic,
                      color: Colors.black,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(40),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(
                    FontAwesomeIcons.filter,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search() {
    print('search');
  }
}
