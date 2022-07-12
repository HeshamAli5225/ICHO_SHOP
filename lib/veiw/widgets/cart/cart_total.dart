import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../../utils/my_string.dart';

class CartTotal extends StatelessWidget {
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextUtils(
                  text: tr(StringManger.total),
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                TextUtils(
                  text: '\$${controller.total.toStringAsFixed(2)}',
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        primary: Get.isDarkMode ? pinkClr : mainColor,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.placeOrder);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                            text: tr(StringManger.checkOut),
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.shopping_cart)
                        ],
                      ))),
            )
          ],
        ),
      );
    });
  }
}
