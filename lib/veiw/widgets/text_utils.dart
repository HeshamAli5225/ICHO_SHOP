import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  TextDecoration ? underLine=TextDecoration.none;
   TextUtils({required this.text,required this.color,required this.fontSize,required this.fontWeight,Key? key,this.underLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: underLine,
        ),
      )
    );
  }
}
