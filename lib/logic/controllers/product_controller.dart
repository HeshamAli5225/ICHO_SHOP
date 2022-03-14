import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/services/product_services.dart';

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;
  var favouritesList = <ProductModel>[].obs;
  var isLoading = true.obs;
  var storage = GetStorage();

  var searchList = <ProductModel>[].obs;
  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProduct();
    List? favouritesList = storage.read<List>('favouritesList');
    if (favouritesList != null) {
      this.favouritesList =
          favouritesList.map((e) => ProductModel.fromJson(e)).toList().obs;
    }
  }

  void getProduct() async {
    var products = await ProductServices.getProduct();
    try {
      isLoading.value = true;
      if (products.isNotEmpty) {
        productList.addAll(products);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  ////////////////////Logic for favourite////////////////

  void changeFavourites(int productId) async {
    var productIndex =
        favouritesList.indexWhere((element) => element.id == productId);
    if (productIndex >= 0) {
      favouritesList.removeAt(productIndex);
      await storage.write('favouritesList', favouritesList);
    } else {
      favouritesList
          .add(productList.firstWhere((element) => element.id == productId));
      await storage.write('favouritesList', favouritesList);
    }
//    productList.forEach((element) {
//      if(element.id==productId){
//
//        bool exist=false;
//        favouritesList.forEach((element) {
//          if(element.id==productId){favouritesList.remove(element);exist=true;}
//
//        });
//        if(!exist){favouritesList.add(element);}
//
//
//      }
//    });
    //favouritesList.add(productList.firstWhere((element){element.id==productId;}));
  }

//  void removeFromFavourites(int productId){
//    favouritesList.removeWhere((element) => element.id==productId);
//  }

  bool isFavourites(int productId) {
    return favouritesList.any((element) => element.id == productId);
  }

////////////////////Logic for Search////////////////

  void addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();
    searchList.value = productList.where((product) {
      var productTitle = product.title.toLowerCase();
      return productTitle.contains(searchName) ||
          product.price.toString().contains(searchName);
    }).toList();
    update();
  }

  void cleanSearch() {
    searchList.clear();
    update();
  }
}

