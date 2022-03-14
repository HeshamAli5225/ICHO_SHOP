import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/veiw/widgets/ProductDetails/add_cart.dart';
import 'package:shop/veiw/widgets/ProductDetails/image_sliders.dart';
import 'package:shop/veiw/widgets/ProductDetails/product_info.dart';
import 'package:shop/veiw/widgets/ProductDetails/size_list.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  ProductDetailsScreen({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSliders(image: productModel.image,),
              ProductInfo(title: productModel.title,productId: productModel.id,rate: productModel.rating.rate,description: productModel.description,),
              SizeList(),
              AddCart(productModel: productModel,price: productModel.price,),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
