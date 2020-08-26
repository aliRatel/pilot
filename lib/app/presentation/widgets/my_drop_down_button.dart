import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pilot/core/util/consts.dart';

class MyDropDownButton extends StatefulWidget {
  final List items;
  final ValueChanged<dynamic> valueChanged;
  final dynamic initialValue;
  final FocusNode focusNode;
  final String hint;

  const MyDropDownButton({
    Key key,
    @required this.items,
    this.valueChanged,
    @required this.initialValue,
    this.focusNode,
    this.hint = '',
  }) : super(key: key);

  @override
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(12),
      ),
      child: Container(
        height: ScreenUtil().setHeight(55),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(12),
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: mainColor,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            focusNode: widget.focusNode,
            value: widget.initialValue,
            hint: Text(widget.hint),
            items: widget.items
                .map(
                  (item) => DropdownMenuItem(
                    child: Text(item.name.toString()),
                    value: item,
                  ),
                )
                .toList(),
            onChanged: (newItem) {
              widget.valueChanged(newItem);
            },
          ),
        ),
      ),
    );
  }
}
