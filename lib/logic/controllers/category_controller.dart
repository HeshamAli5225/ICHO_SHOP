
import 'package:get/get.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/services/category_services.dart';

class CategoryController extends GetxController{

  var categoryNameList=<String>[].obs;
  var categoryProductList=<ProductModel>[].obs;
  var isLoading=true.obs;
  var isCategoryProductLoading=true.obs;

  @override
  void onInit() {

    super.onInit();
    getCategory();
  }

  void getCategory()async{
    var categoryName=await CategoryServices.getCategory();
    try{
      isLoading.value=true;
      if(categoryName.isNotEmpty){
        categoryNameList.addAll(categoryName);
      }

    }
    catch(e){}
    finally{
      isLoading(false);
    }
  }

  getCategoryProduct(String catName)async{
    isCategoryProductLoading.value=true;
    categoryProductList.value= await CategoryProductServices.getCategoryProduct(catName);


      isCategoryProductLoading(false);

  }

  getCategoryIndex(int index)async{
    var categoryProduct=await getCategoryProduct(categoryNameList[index]);
    if(categoryProduct !=null){
      categoryProductList.value=categoryProduct;
    }
  }

}