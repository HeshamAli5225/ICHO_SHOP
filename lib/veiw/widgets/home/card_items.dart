import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/logic/controllers/product_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';
import 'package:get/get.dart';
// import 'package:collection/collection.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/favorite_provider.dart';
import '../../../utils/scaffold_helper.dart';
import '../../screens/suppliers/manage_product/product_details.dart';

class CardItems extends StatefulWidget {
  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems> {
  final controller = Get.put(ProductController());

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();
  final Stream<QuerySnapshot> _prodcutsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

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
                          proList: snapshot.data!.docs[index],
                          image: snapshot.data!.docs[index]["proimages"][0],
                          price: snapshot.data!.docs[index]["price"],
                          rate:  3.4,
                          productId: snapshot.data?.docs[index]["proid"],
                          // productModel: controller.productList[index],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsScreen(
                                  proList: snapshot.data!.docs[index],
                                );
                              },
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
                        proList: snapshot.data!.docs[index],
                          context: context,
                          image: controller.searchList[index].image,
                          price: controller.searchList[index].price,
                           rate:3.4,
                          productId: controller.searchList[index].id.toString(),
                          // productModel: controller.searchList[index],
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsScreen(
                                  proList: snapshot.data!.docs[index],
                                );
                              },
                            ));
                          });
                    },
                  ),
                );
              }
            }
          });
        });
  }

  Widget buildCardItems(

      {required BuildContext context,
      required var image,
      required var price,
      required double rate,
      required String productId,
      required dynamic proList,
      // required ProductModel productModel,
      required Function() onTap}) {
    var onSale = proList['discount'];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var existingItemCart = context.watch<Cart>().getItems.firstWhereOrNull(
            (element) => element.documentId == proList['proid']);
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

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            var existingItemWishlist = context
                                .read<Favorite>()
                                .getWishItems
                                .firstWhereOrNull((product) =>
                                    product.documentId == proList['proid']);
                            existingItemWishlist != null
                                ? context
                                    .read<Favorite>()
                                    .removeThis(proList['proid'])
                                : context.read<Favorite>().addWishItem(
                                      proList['proname'],
                                      onSale != 0
                                          ? ((1 - (proList['discount'] / 100)) *
                                              proList['price'])
                                          : proList['price'],
                                      1,
                                      proList['instock'],
                                      proList['proimages'],
                                      proList['proid'],
                                      proList['sid'],
                                    );
                          },
                          icon: context
                                      .watch<Favorite>()
                                      .getWishItems
                                      .firstWhereOrNull((product) =>
                                          product.documentId ==
                                          proList['proid']) !=
                                  null
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  color:Colors.grey,
                                  size: 30,
                                )),
                      IconButton(
                          onPressed: () {
                            if (proList['instock'] <= 0) {
                              MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'this item is out of stock');
                            } else if (existingItemCart != null) {
                              MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'this item already in cart');
                            } else {
                              context.read<Cart>().addItem(
                               proList['proname'],
                                onSale != 0
                                    ? ((1 -
                                    (proList['discount'] /
                                        100)) *
                                   proList['price'])
                                    :proList['price'],
                                1,
                               proList['instock'],
                               proList['proimages'],
                               proList['proid'],
                               proList['sid'],
                              );
                            }
                          },
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
                    ],
                  ),

                Container(
                  width: double.infinity,
                  height: height * .20,
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
      ),
    );
  }
}
