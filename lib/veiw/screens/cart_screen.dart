import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/cart/cart_product.dart';
import 'package:shop/veiw/widgets/cart/cart_total.dart';
import 'package:shop/veiw/widgets/cart/empty_cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final controller = Provider.of<Cart>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          tr(StringManger.cartItem),
        ),
        elevation: 0,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
        centerTitle: true,
        actions: !context.watch<Cart>().getItems.isEmpty
            ? [
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                          backgroundColor: Colors.grey,
                          title: tr(StringManger.cleanProduct),
                          titleStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          middleText: tr(StringManger.sureDeleteAll),
                          middleTextStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textCancel: tr(StringManger.no),
                          cancelTextColor: Colors.white,
                          onCancel: () {
                            Get.offNamed(Routes.cartScreen);
                          },
                          textConfirm: tr(StringManger.yes),
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.clearCart();
                            Get.offNamed(Routes.mainScreen);
                          },
                          buttonColor: Get.isDarkMode ? pinkClr : mainColor);

                      //controller.removeAllCart();
                    },
                    icon: Icon(Icons.backspace))
              ]
            : [],
      ),
      backgroundColor: context.theme.backgroundColor,
      body: (context.watch<Cart>().getItems.isEmpty)
          ? EmptyCart()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .73,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CartProduct(
                              product: controller.getItems[index],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemCount: controller.count??0,
                        ),
                      ),
                    ],
                  ),
                ),
                CartTotal()
              ],
            ),
    ));
  }
}
