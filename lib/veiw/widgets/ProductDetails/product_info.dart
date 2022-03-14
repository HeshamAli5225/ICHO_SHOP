import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shop/logic/controllers/product_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class ProductInfo extends StatelessWidget {
  final String title;
  final int productId;
  final double rate;
  final String description;
  final controller = Get.find<ProductController>();

  ProductInfo(
      {required this.title,
      required this.productId,
      required this.rate,
      required this.description,
      }); //final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Obx(() {
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white.withOpacity(0.9)
                        : Colors.grey.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.changeFavourites(productId);
                    },
                    child: controller.isFavourites(productId)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 23,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 23,
                          ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 3,),
          Row(
            children: [
              TextUtils(
                text: rate.toString(),
                color: Get.isDarkMode?Colors.white:Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold ,
              ),
              SizedBox(width: 5,),
              RatingBarIndicator(
                rating: rate,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,

              ),


//              RatingBar(
//                rating: rate,
//                size: 20,
//                color: Colors.orangeAccent,
//                icon: Icon(Icons.star),
//                starCount: 5,
//                spacing: 1,
//                allowHalfRating: true,
//                isIndicator: false,
//                onRatingCallback: (value,isIndicator){isIndicator.value=true;},
//              )
            ],
          ),
          SizedBox(height: 5,),
          ReadMoreText(
            description
            ,trimLines: 3,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show Less',
            lessStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode?pinkClr:mainColor
            ),
            moreStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode?pinkClr:mainColor
            ),
            style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode?Colors.white:Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
