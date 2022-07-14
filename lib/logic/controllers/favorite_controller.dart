import 'package:get/get.dart';
import 'package:shop/model/product_model.dart';

class FavoriteController extends GetxController {
  var favoriteMap = {}.obs;

  void addProductToFavorite(ProductModel productModel) {
    if (!favoriteMap.containsKey(productModel)) {
      favoriteMap[productModel] = 1;
    }
  }

  void removeProductFromFavorite(ProductModel productModel) {
    favoriteMap.remove(productModel);
  }

  void removeAllCart() {
    favoriteMap.clear();
  }

  void increaseNumberOfProduct(ProductModel productModel) {
    favoriteMap[productModel] += 1;
  }

  void decreaseNumberOfProduct(ProductModel productModel) {
    if (favoriteMap[productModel] > 1) {
      favoriteMap[productModel] -= 1;
    }
  }

//  double productTotal(ProductModel productModel){
//    return favoriteMap[productModel]*productModel.price;
//  }

//  double allProductTotal(){
//    double total=0.0;
//    ProductMap.forEach((key, value) {
//      total+=ProductMap[key]*key.price;
//    });
//    return total;
//  }

}
