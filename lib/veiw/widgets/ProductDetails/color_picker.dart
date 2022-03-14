import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final Color color;
  final bool outerBorder;
  ColorPicker(this.color, this.outerBorder);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: outerBorder?Border.all(color: color,width: 2):null,

      ),
      child: Container(
        padding: EdgeInsets.all(15),
         // height: 15,
         // width: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color
            //border: outerBorder?Border.all(color: color,width: 2):null,

          )
      ),
    );
  }
}
