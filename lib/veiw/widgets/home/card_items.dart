import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/logic/controllers/product_controller.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/screens/product_details_screen.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class CardItems extends StatelessWidget {
  final controller = Get.put(ProductController());
  final cartController = Get.put(CartController());
  final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('products').snapshots();
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(

      stream: _prodcutsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text(
                'This category \n\n has no items yet !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme',
                    letterSpacing: 1.5),
              ));
        }
        return Obx(() {
          if (controller.isLoading.value) {
            return Expanded(
                child: Container(
                    child: Center(
              child: CircularProgressIndicator(
                color: Get.isDarkMode ? pinkClr : mainColor,
              ),
            )));
          } else {
            if (controller.searchList.isEmpty &&
                controller.searchController.text.isNotEmpty) {
              return Expanded(
                  child: Get.isDarkMode
                      ? Image.asset('assets/images/search_empty_dark.png')
                      : Image.asset('assets/images/search_empry_light.png'));
            } else if (controller.searchList.isEmpty) {
              return Expanded(
                child: GridView.builder(
                  itemCount: snapshot.data?.docs.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    return buildCardItems(
                        context: context,
                        image: snapshot.data!.docs[index]["proimages"][0],
                        price: snapshot.data!.docs[index]["price"],
                        // rate: controller.productList[index].rating.rate,
                        productId:snapshot.data?.docs[index]["proid"],
                        // productModel: controller.productList[index],
                        onTap: () {
                          Get.to(ProductDetailsScreen(
                            productModel: controller.productList[index],
                          ));
                        });
                  },
                ),
              );
            } else {
              return Expanded(
                child: GridView.builder(
                  itemCount: controller.searchList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    return buildCardItems(
                        context: context,
                        image: controller.searchList[index].image,
                        price: controller.searchList[index].price,
                        // rate: controller.searchList[index].rating.rate,
                        productId: controller.searchList[index].id.toString(),
                        // productModel: controller.searchList[index],
                        onTap: () {
                          Get.to(ProductDetailsScreen(
                            productModel: controller.searchList[index],
                          ));
                        });
                  },
                ),
              );
            }
          }
        });
      }
    );
  }

  Widget buildCardItems(
      {
        required BuildContext context,
        required var image,
      required var price,
      // required double rate,
      required String productId,
      // required ProductModel productModel,
      required Function() onTap}) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
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
          child: SingleChildScrollView(
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
                            // todo
                            // cartController.addProductToCart(productModel);
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
                  height: height*.20,
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
                          text: 'EGP ${price}',
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
                                // todo
                                text: '3.4',
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
      ),
    );
  }
}
