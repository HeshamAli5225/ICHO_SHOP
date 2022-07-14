import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/product_controller.dart';

import '../../../utils/my_string.dart';

class SearchFormText extends StatelessWidget {
  final controller=Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (x){

      return TextField(
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      controller: controller.searchController,
      onChanged: (searchName){
        controller.addSearchToList(searchName);
      },
      decoration: InputDecoration(
        suffixIcon: controller.searchController.text.isNotEmpty?IconButton( icon: Icon(Icons.close,color: Colors.black,),

          onPressed:
          (){controller.searchController.text='';;controller.cleanSearch();}
        ,

        ):null,
        hintText: tr(StringManger.searchWith),
        hintStyle: TextStyle(fontSize: 16,
            fontWeight: FontWeight.w500,color: Colors.black45),
        focusColor: Colors.red,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search,color: Colors.grey,),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide:BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10)),


        ),

        errorBorder: OutlineInputBorder(
          borderSide:BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10)),


        ),
      ),
    );});
  }

  void m(){}
}

