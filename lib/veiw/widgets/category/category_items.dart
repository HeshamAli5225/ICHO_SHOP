import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/logic/controllers/category_controller.dart';
import 'package:shop/logic/controllers/product_controller.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/screens/product_details_screen.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class CategoryItems extends StatelessWidget {
  final String CategoryTitle;
  CategoryItems({required this.CategoryTitle});

  final controller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  final categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CategoryTitle,
        ),
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
      ),
      backgroundColor: context.theme.backgroundColor,
      body: Obx(() {
        if (categoryController.isCategoryProductLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
          );
        } else {
          return GridView.builder(
            itemCount: categoryController.categoryProductList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.8,
              mainAxisSpacing: 9,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              return buildCardItems(
                  image: categoryController.categoryProductList[index].image,
                  price: categoryController.categoryProductList[index].price,
                  rate: categoryController.categoryProductList[index].rating.rate,
                  //todo
                  productId: categoryController.categoryProductList[index].id.toString(),
                  productModel: categoryController.categoryProductList[index],
                  onTap: () {
                    Get.to(ProductDetailsScreen(
                      productModel: categoryController.categoryProductList[index],
                    ));
                  });
            },
          );
        }
      }),
    );
  }

  Widget buildCardItems(
      {required String image,
      required double price,
      required double rate,
      required String productId,
      required ProductModel productModel,
      required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                ),
              ]),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.changeFavourites(productId);
                        },
                        icon: controller.isFavourites(productId)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_outline,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              )),
                    IconButton(
                        onPressed: () {
                          cartController.addProductToCart(productModel);
                          //print(cartController.allProductTotal());
                        },
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        )),
                  ],
                );
              }),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Image(
                  image: NetworkImage(
                    '$image',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils(
                        text: '\$ ${price}',
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    Container(
                      height: 20,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? pinkClr : mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 2),
                        child: Row(
                          children: [
                            TextUtils(
                              text: '${rate}',
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            Icon(
                              Icons.star,
                              size: 13,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
