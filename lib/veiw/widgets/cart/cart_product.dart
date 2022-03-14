import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../../model/product_model.dart';

class CartProduct extends StatelessWidget {

  final ProductModel productModel;
  final controller=Get.find<CartController>();

  CartProduct({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ?Colors.grey[600]
              : mainColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    '${productModel.image}',
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productModel.title}',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${controller.productPriceMap[productModel].toStringAsFixed(2)}',

                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            //flex: 9,
          ),
          //Spacer(flex: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {
                    controller.decreaseNumberOfProduct(productModel);
                  }, icon: Icon(Icons.remove_circle,
                    color: Get.isDarkMode?Colors.white:Colors.black,
                  )),
                  TextUtils(
                    text: '${controller.productMap[productModel]}',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(onPressed: (){
                    controller.increaseNumberOfProduct(productModel);
                  }, icon: Icon(Icons.add_circle,
                    color: Get.isDarkMode?Colors.white:Colors.black,
                  )),

                ],
              ),
              IconButton(onPressed: (){
                controller.removeProductFromCart(productModel);
              }, icon: Icon(Icons.delete,color: Colors.red,))
            ],
          )
        ],
      ),
    );
  }
}
