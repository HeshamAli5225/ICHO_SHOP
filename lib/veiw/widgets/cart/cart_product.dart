import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../../model/product_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/product_class.dart';

class CartProduct extends StatelessWidget {
  final Product product;

  CartProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Cart>(context);

    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .18,
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[600] : mainColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      '${product.imagesUrl[0]}',
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${(product.price*product.qty).toStringAsFixed(2)}',
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
                  IconButton(
                      onPressed: () {
                        controller.decrement(product);
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )),
                  Text(
                    product.qty.toString(),
                    style: product.qty == product.qntty
                        ? const TextStyle(
                            fontSize: 20, fontFamily: 'Acme', color: Colors.red)
                        : const TextStyle(fontSize: 20, fontFamily: 'Acme'),
                  ),
                  IconButton(
                      onPressed: product.qty == product.qntty
                          ? null
                          : () {
                              controller.increment(product);
                            },
                      icon: Icon(
                        Icons.add_circle,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )),
                ],
              ),
              IconButton(
                  onPressed: () {
                    controller.removeItem(product);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
