import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/category_controller.dart';
import 'package:shop/logic/controllers/product_controller.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/category/category_items.dart';
import 'package:collection/collection.dart';

class CategoryWidgit extends StatelessWidget {
  final controller=Get.put(CategoryController());
  final productController=Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.isLoading.value){
        return Center(child: CircularProgressIndicator(
          color: Get.isDarkMode?pinkClr:mainColor,
        ),);
      }
      else{
        return  Expanded(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                controller.getCategoryIndex(index);
                Get.to(()=>CategoryItems(CategoryTitle: controller.categoryNameList[index],));
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg'
                          //productController.productList.firstWhere((element) => controller.categoryNameList[index].toString()==element.category.toString()).image

                      ),
                      fit: BoxFit.fill,

                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,bottom: 15),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(controller.categoryNameList[index],style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black45,
                    ),),
                  ),
                ),
              ),);
          },
          separatorBuilder: (context, index) {return SizedBox(height: 20,);},
          itemCount: controller.categoryNameList.length,
        ),
      );}});}

  }

