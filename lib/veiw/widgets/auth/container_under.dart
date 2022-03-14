import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class ContainerUnder extends StatelessWidget {
  final String text;
  final String textType;
  final Function() onPressed;

  const ContainerUnder({required this.text,required this.textType,required this.onPressed,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Get.isDarkMode?pinkClr:mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
            text: text,
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          TextButton(onPressed: onPressed, child: TextUtils(
            text: textType,
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            underLine: TextDecoration.underline,
          ),)
        ],
      ),
    );
  }
}
