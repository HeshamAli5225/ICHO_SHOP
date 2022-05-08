
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../../utils/my_string.dart';

class AddCart extends StatelessWidget {
  final double price;
  final ProductModel productModel;
  final controller=Get.find<CartController>();


  AddCart({required this.price,required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              TextUtils(
                text: tr(StringManger.price),
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              TextUtils(
                text: '\$${price}',
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
                        controller.addProductToCart(productModel);
                      }
   ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                            text: tr(StringManger.addToCart),
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.shopping_cart)
                        ],
                      ))))
        ],
      ),
    );
  }
}
