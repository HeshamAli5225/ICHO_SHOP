import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/logic/controllers/category_controller.dart';
import 'package:shop/logic/controllers/product_controller.dart';


class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.lazyPut(() => CartController());
    Get.put(CategoryController());
  }

}