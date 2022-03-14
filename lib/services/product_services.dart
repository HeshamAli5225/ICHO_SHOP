import 'package:http/http.dart' as http;
import 'package:shop/model/product_model.dart';
import 'package:shop/utils/my_string.dart';

class ProductServices{

  static Future<List<ProductModel>> getProduct()async{
    var response=await http.get(Uri.parse('$baseUrl/products'));
    if(response.statusCode==200){
      var jsonData=response.body;
      return productModelFromJson(jsonData);
    }
    else{
      return throw Exception('Faild to load product');
    }

  }
}