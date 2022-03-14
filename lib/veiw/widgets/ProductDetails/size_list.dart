import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/utils/theme.dart';

class SizeList extends StatefulWidget {
  @override
  _SizeListState createState() => _SizeListState();
}

class _SizeListState extends State<SizeList> {
  List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
  var selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: 60,
      //color: Colors.grey,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){return GestureDetector(
            onTap: (){
              setState(() {
                selectedSize=index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Get.isDarkMode?selectedSize==index?pinkClr.withOpacity(0.4):Colors.black
                    :selectedSize==index?mainColor.withOpacity(0.4):Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Get.isDarkMode?selectedSize==index?pinkClr.withOpacity(0.4):Colors.grey.withOpacity(0.6)
                      :selectedSize==index?mainColor.withOpacity(0.4):Colors.grey.withOpacity(0.6),
                  width: 2,
                )
              ),
              child: Text(sizeList[index],style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ));},
        separatorBuilder: (context,index){return SizedBox(width: 10,);},
        itemCount: sizeList.length,
      ),
    );
  }
}
