

import 'package:shop/model/category_model.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/utils/my_string.dart';
import 'package:http/http.dart' as http;


class CategoryServices{
  static Future<List<String>> getCategory()async{
    var response=await http.get(Uri.parse('${StringManger.baseUrl}/products/categories'));
    if(response.statusCode==200){
      var jsonData=response.body;
      return categoryModelFromJson(jsonData);
    }
    else{
      return throw Exception('Faild to load Category');
    }

  }
}

class CategoryProductServices{

  static Future<List<ProductModel>> getCategoryProduct(String categoryName)async{
    var response=await http.get(Uri.parse('${StringManger.baseUrl}/products/category/$categoryName'));
    if(response.statusCode==200){
      var jsonData=response.body;
      return productModelFromJson(jsonData);
    }
    else{
      return throw Exception('Faild to load CategoryProduct');
    }

  }
}