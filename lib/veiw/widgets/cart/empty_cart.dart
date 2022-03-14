import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 180,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextUtils(
                text: 'Your Cart is ',
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
              TextUtils(
                text: 'Empty',
                color: Get.isDarkMode ? pinkClr : mainColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextUtils(
            text: 'Add items to get started',
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                primary: Get.isDarkMode?pinkClr:mainColor,
              ),
              onPressed: () {Get.offNamed(Routes.mainScreen);},
              child: TextUtils(
                text: 'Go to Home',
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
