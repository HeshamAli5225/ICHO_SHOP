import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  AuthButton({required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Get.isDarkMode?pinkClr:mainColor,
        minimumSize: const Size(360, 50),
      ),
      onPressed: onPressed,
      child: TextUtils(
        text: text,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
