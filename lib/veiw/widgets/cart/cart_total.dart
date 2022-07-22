import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../../providers/cart_provider.dart';
import '../../../utils/my_string.dart';

class CartTotal extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

      final controller = Provider.of<Cart>(context);
      final height =
          MediaQuery.of(context).size.height;
      final width =
          MediaQuery.of(context).size.width;
      return Container(
        padding: EdgeInsets.all(10),
        height: height*0.12,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextUtils(
                  text: tr(StringManger.total),
                  color: Colors.grey,
                  fontSize: height*0.03,
                  fontWeight: FontWeight.w600,
                ),
                TextUtils(
                  text: 'EGP ${controller.totalPrice.toStringAsFixed(2)}',
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: height*0.04,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
            SizedBox(
              width: width*0.02,
            ),
            Expanded(
              child: Container(
                  height: height*0.12,
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
                            fontSize: height*0.034,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: width*0.025,
                          ),
                          Icon(Icons.shopping_cart,size: height*0.04,)
                        ],
                      ))),
            )
          ],
        ),
      );

  }
}
