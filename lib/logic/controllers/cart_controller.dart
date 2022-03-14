import 'package:get/get.dart';
import 'package:shop/model/product_model.dart';

class CartController extends GetxController{

  var productMap={}.obs;
  var productPriceMap={}.obs;
  RxDouble total=0.0.obs;

  void addProductToCart(ProductModel productModel){
    if(!productMap.containsKey(productModel)){
      productMap[productModel]=1;
      productPriceMap[productModel]=productModel.price;
      total.value+=productModel.price;
    }
  }
  void removeProductFromCart(ProductModel productModel){
    productPriceMap[productModel]-=productMap[productModel]*productModel.price;
    total.value-=productMap[productModel]*productModel.price;
    productMap.remove(productModel);

  }


  void removeAllCart(){
    productMap.clear();
    productPriceMap.clear();
    total.value=0;
  }
  void increaseNumberOfProduct(ProductModel productModel){
    productMap[productModel]+=1;
    total.value+=productModel.price;
    productPriceMap[productModel]+=productModel.price;
  }
  void decreaseNumberOfProduct(ProductModel productModel){
    if(productMap[productModel]>1){
      productMap[productModel]-=1;
      productPriceMap[productModel]-=productModel.price;
      total.value-=productModel.price;
    }

  }


//  double productTotal(ProductModel productModel){
//    return productMap[productModel]*productModel.price;
//  }


//  double allProductTotal(){
//    double total=0.0;
//    ProductMap.forEach((key, value) {
//      total+=ProductMap[key]*key.price;
//    });
//    return total;
//  }


}