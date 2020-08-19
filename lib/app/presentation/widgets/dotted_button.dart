import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedButton extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final BorderType borderType;
  final Radius radius;
  final Color dottedColor;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Function onTap;

  const DottedButton({
    Key key,
    this.width,
    this.height,
    this.backgroundColor,
    @required this.child,
    this.borderRadius,
    this.padding,
    this.borderType,
    this.radius,
    this.dottedColor,
    this.strokeWidth,
    this.strokeCap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: borderType ?? BorderType.RRect,
      radius: radius ?? Radius.circular(30),
      padding: padding ?? EdgeInsets.all(8),
      strokeWidth: strokeWidth ?? 1.5,
      strokeCap: strokeCap ?? StrokeCap.butt,
      color: dottedColor ?? Colors.black,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(30)),
        child: Container(
          height: height ?? 120,
          width: width ?? 140,
          color: backgroundColor ?? Colors.amber,
          child: FlatButton(
            child: Center(child: child),
            onPressed: onTap ?? () {},
          ),
        ),
      ),
    );
  }
}
