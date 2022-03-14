import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/veiw/screens/cart_screen.dart';

class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CartScreen());
  }

}