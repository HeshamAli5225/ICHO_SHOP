import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/ProductDetails/color_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSliders extends StatefulWidget {
  final String image;
  ImageSliders({required this.image});

  @override
  State<ImageSliders> createState() => _ImageSlidersState();
}

class _ImageSlidersState extends State<ImageSliders> {
  CarouselController carouselController = CarouselController();

  int currentPage = 0;
  int currentColor = 0;
  final cartController = Get.find<CartController>();
  final List <Color> colorSelected=[kCOlor1,kCOlor2,kCOlor3,kCOlor4,kCOlor5];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          carouselController: carouselController,
          options: CarouselOptions(
              height: 500,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlayInterval: Duration(seconds: 3),
              viewportFraction: 1,
              onPageChanged: (index, reson) {
                setState(() {
                  currentPage = index;
                });
              }),
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.image,
                  ),

                  //fit: BoxFit.fill,
                ),
                // borderRadius: BorderRadius.circular(25),
              ),
            );
          },
        ),
        Positioned(
          bottom: 10,
          left: 170,
          child: AnimatedSmoothIndicator(
            activeIndex: currentPage,
            count: 3,
            effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Get.isDarkMode ? pinkClr : mainColor),
          ),
        ),
        Positioned(
            bottom: 30,
            right: 30,
            child: Container(
              height: 200,
              width: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView.separated(
                itemBuilder: (context,index){return GestureDetector(child: ColorPicker(colorSelected[index], currentColor==index),onTap: (){
                  setState(() {
                    currentColor=index;
                  });
                },);},
                separatorBuilder: (context,index){return SizedBox(height: 3,);},
                itemCount: colorSelected.length,
              ),
            )),
        Container(
          padding: EdgeInsets.only(top: 20,left: 25,right: 25),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.isDarkMode?Colors.grey.withOpacity(0.8):mainColor.withOpacity(0.8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.arrow_back_ios,
                      color: Get.isDarkMode?Colors.black:Colors.white,
                    ),
                  ),

                ),
              ),
              Obx(() {
                if(cartController.productMap.isEmpty){return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.cartScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Get.isDarkMode?Colors.grey.withOpacity(0.8):mainColor.withOpacity(0.8),
                    ),
                    child: Icon(Icons.shopping_cart,
                      color: Get.isDarkMode?Colors.black:Colors.white,
                    ),

                  ),
                );}
                else{
                  return  Badge(
                  position: BadgePosition.topEnd(top: -10, end: -7),
                  animationDuration: Duration(milliseconds: 300),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    '${cartController.productMap.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(Routes.cartScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Get.isDarkMode?Colors.grey.withOpacity(0.8):mainColor.withOpacity(0.8),
                        ),
                        child: Icon(Icons.shopping_cart,
                          color: Get.isDarkMode?Colors.black:Colors.white,
                        ),

                      ),
                    ),


                );}
                }),

          ],),
        )
      ],
    );
  }
}
