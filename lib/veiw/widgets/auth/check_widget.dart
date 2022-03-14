import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/auth_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class CheckWidget extends StatelessWidget {
  final controller=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (x){return Row(
      children: [
        InkWell(
          onTap: () {
            controller.checkBox();
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: controller.isCheckBox?Get.isDarkMode?Icon(Icons.check,size: 35,color: pinkClr,):Image.asset('assets/images/check.png'):Container(),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            TextUtils(
              text: 'I accept',
              color: Get.isDarkMode?Colors.white:Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(width: 5,),
            TextUtils(
              text: 'terms && conditions',
              color: Get.isDarkMode?Colors.white:Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              underLine: TextDecoration.underline,
            ),
          ],
        )
      ],
    );});
  }
}
