import 'package:flutter/cupertino.dart';

class Divider extends StatelessWidget {
  const Divider({
    super.key,
    this.color,
    this.thickness = 0.5,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.height = 16.0,
  });

  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(
            start: indent,
            end: endIndent,
          ),
          decoration: BoxDecoration(
            color: color ?? CupertinoColors.separator,
          ),
        ),
      ),
    );
  }
}
